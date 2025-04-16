import 'dart:convert';

import 'package:mech_app/data/globals.dart';
import 'package:mech_app/data/models/customer_model.dart';

import 'package:http/http.dart' as http;
import 'package:mech_app/services/api_services/token_sevice.dart';

class UserServices {
  // Function to fetch user profile data
  static Future<CustomerModel?> fetchUserProfile() async {
    //token
    bearer_token = await TokenService.getToken();
    if (bearer_token == null) {
      print("❌ Error: No token found.");
      return null;
    }

    final response = await http.get(
      Uri.parse("$api_url/userprofile/"),
      headers: {
        "Authorization": "Bearer $bearer_token",
        // "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      return CustomerModel.fromJson(data);
    } else {
      print("❌ Error: ${response.statusCode} - ${response.body}");
      return null;
    }
  }

  static Future<bool?> updateCustomerProfile(
    int userId,
    Map<String, dynamic> updates,
  ) async {
    final url = Uri.parse("$api_url/customers/$userId/");

    //token
    bearer_token = await TokenService.getToken();
    try {
      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $bearer_token",
        },
        body: jsonEncode(updates),
      );

      if (response.statusCode == 200) {
        print("Profile updated successfully: ${response.body}");

        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        return true;
      } else {
        print("Failed to update profile: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error updating profile: $e");
      return false;
    }
  }
}
