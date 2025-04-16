import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mech_app/data/globals.dart';
import 'package:mech_app/services/api_services/token_sevice.dart';

class AuthService {
  static const String baseUrl =
      "https://mechanic-backend-rofz.onrender.com/api";

  // static Future<bool?> login(String phone, String password) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("$baseUrl/login/"),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({"phone_number": phone, "password": password}),
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = jsonDecode(response.body);

  //       print(data);
  //       return true;
  //     } else {
  //       print("Login failed: ${response.body}");
  //       return false;
  //     }
  //   } catch (e) {
  //     print("Login error: $e");
  //     return false;
  //   }
  // }

  static Future<bool> register(String phone, String password) async {
    final response = await http.post(
      Uri.parse('$api_url/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone_number": phone, "password": password}),
    );

    return response.statusCode == 200;
  }

  /// Logout user by clearing stored tokens
  static Future<void> logout() async {
    await TokenService.clearTokens();
  }
}

// old code ============

// class AuthServices {
//   Future<LoginModel> loginUser(
//     String username,
//     String email,
//     String passoword,
//   ) async {
//     const url = '$baseurl/admin/login';

//     final response = await http.post(
//       Uri.parse(url),
//       body: {"username": username, "email": email, "password": passoword},
//     );

//     LoginModel data = jsonDecode(response.body);
//     return data;
//   }

//   Future<RegisterModel> registerUser(
//     String username,
//     String email,
//     String passoword,
//     String fullname,
//     String role,
//     String department,
//   ) async {
//     const url = '$baseurl/admin/login';

//     final response = await http.post(
//       Uri.parse(url),
//       headers: {
//         "username": username,
//         "email": username,
//         "fullName": fullname,
//         "password": passoword,
//         "role": role,
//         "department": department,
//       },
//     );

//     RegisterModel data = jsonDecode(response.body);
//     return data;
//   }
// }
