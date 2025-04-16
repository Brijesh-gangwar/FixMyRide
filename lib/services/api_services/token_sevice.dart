import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class TokenService {
  static const String baseUrl = "https://mechanic-backend-rofz.onrender.com/api/login/";

  /// Save access and refresh tokens
  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }

  /// Get a valid access token (refresh if expired)
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) return null;

    if (isTokenExpired(token)) {
      return await refreshAccessToken();
    }

    return token;
  }

  /// Check if the token is expired
  static bool isTokenExpired(String token) {
    try {
      final jwt = JWT.decode(token);
      final expiry = jwt.payload['exp'];
      if (expiry == null) return true; // No expiry claim, assume expired

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
      return expiryDate.isBefore(DateTime.now());
    } catch (e) {
      return true; // If decoding fails, assume expired
    }
  }

  /// Refresh access token using refresh token
  static Future<String?> refreshAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString('refresh_token');

    if (refreshToken == null) return null;

    final response = await http.post(
      Uri.parse('$baseUrl/refresh'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refresh_token": refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await saveTokens(data['access_token'], data['refresh_token']);
      return data['access_token'];
    } else {
      await clearTokens(); // Clear invalid tokens
      return null;
    }
  }

  /// Clear stored tokens
  static Future<void> clearTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('refresh_token');
  }
}
