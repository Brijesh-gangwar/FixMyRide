import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mech_app/data/globals.dart';



class ApiPostServices {


  static Future<http.Response> createResouces(
      {required String name,
      required String description,
      required String unit}) async {
    final url = Uri.parse('$api_url/api/resource');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'description': description,
          "unit": unit,
        }),
      );
      return response;
    } catch (error) {
      throw Exception('Failed to connect to the API: $error');
    }
  }

  static Future<http.Response> createdept({
    required String name,
    required String description,
  }) async {
    final url = Uri.parse('$api_url/api/createDepartment');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'description': description,
        }),
      );
      return response;
    } catch (error) {
      throw Exception('Failed to connect to the API: $error');
    }
  }

  static Future<http.Response> submitTaskreport({
    required File file,
  }) async {
    final url = Uri.parse('$api_url/api/createDepartment');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'report': file,
        }),
      );
      return response;
    } catch (error) {
      throw Exception('Failed to connect to the API: $error');
    }
  }


  static Future<http.Response> predictdeptconf({
    required String department_1,
    required String department_2,
    required Float latitude,
    required Float longitude,
    required int historical_conflicts,
    required int project_overlap,
    required Float distance,
    required int communication_frequency,
  }) async {
    final url = Uri.parse('$api_url/predict_department_conflict');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'department_1': department_1,
          'department_2': department_2,
          "latitude": latitude,
          "longitude": longitude,
          "historical_conflicts": historical_conflicts,
          "project_overlap": project_overlap,
          "distance": distance,
          "communication_frequency": communication_frequency,
        }),
      );
      return response;
    } catch (error) {
      throw Exception('Failed to connect to the API: $error');
    }
  }
}
