import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // iOS Simulator / Desktop
  // Android Emulator: use http://10.0.2.2:8000
  static const String baseUrl = 'http://127.0.0.1:8000';

  // ============================================================
  // DECODE RESPONSE
  // ============================================================

  static Map<String, dynamic> _decodeResponse(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      return {'success': false, 'message': 'Unexpected server response.'};
    } on FormatException {
      return {'success': false, 'message': 'Invalid server response.'};
    }
  }

  static String _message(Map<String, dynamic> data) {
    return (data['message'] ?? data['detail'] ?? 'Something went wrong.')
        .toString();
  }

  // ============================================================
  // TEST BACKEND CONNECTION
  // ============================================================

  static Future<void> testConnection() async {
    final response = await http.get(Uri.parse('$baseUrl/health'));

    debugPrint('Backend status: ${response.statusCode}');
  }

  // ============================================================
  // SIGN UP
  // ============================================================

  static Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String phone,
    required String countryCode,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'country_code': countryCode,
        'password': password,
      }),
    );

    final data = _decodeResponse(response);

    return {
      'success': response.statusCode == 201 && data['success'] == true,
      'message': _message(data),
      'user_id': data['user_id'],
      'name': data['name'],
      'email': data['email'],
    };
  }

  // ============================================================
  // LOGIN
  // ============================================================

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final data = _decodeResponse(response);

    return {
      'success': response.statusCode == 200 && data['success'] == true,
      'message': _message(data),
      'user_id': data['user_id'],
      'name': data['name'],
      'email': data['email'],
    };
  }

  // ============================================================
  // FORGOT PASSWORD
  // ============================================================

  static Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    final data = _decodeResponse(response);

    return {
      'success': response.statusCode == 200 && data['success'] == true,
      'message': _message(data),
    };
  }

  // ============================================================
  // RESET PASSWORD
  // ============================================================

  static Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token, 'new_password': newPassword}),
    );

    final data = _decodeResponse(response);

    return {
      'success': response.statusCode == 200 && data['success'] == true,
      'message': _message(data),
    };
  }

  // ============================================================
  // GET USER PROFILE
  // ============================================================

  static Future<Map<String, dynamic>> getUserProfile({
    required String userId,
  }) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));

    final data = _decodeResponse(response);

    if (response.statusCode != 200) {
      return {'success': false, 'exists': false, 'message': _message(data)};
    }

    return {
      'success': true,
      'exists': data['exists'] ?? false,
      'user_id': data['user_id'],
      'name': data['name'],
      'email': data['email'],
      'age': data['age'],
      'date_of_birth': data['date_of_birth'],
      'gender': data['gender'],
      'phone': data['phone'],
      'country_code': data['country_code'],
      'height': data['height'],
      'weight': data['weight'],
      'profile_image': data['profile_image'],
      'message': _message(data),
    };
  }

  // ============================================================
  // CREATE OR SAVE USER PROFILE
  // Returns bool to remain compatible with existing callers.
  // ============================================================

  static Future<bool> createUserProfile({
    required String userId,
    required String name,
    required int age,
    required String gender,
    required double height,
    required double weight,
    DateTime? dateOfBirth,
    String? phone,
    String? countryCode,
    String? profileImage,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'name': name,
        'age': age,
        'date_of_birth': dateOfBirth?.toIso8601String().split('T').first,
        'gender': gender,
        'phone': phone,
        'country_code': countryCode,
        'height': height,
        'weight': weight,
        'profile_image': profileImage,
      }),
    );

    final data = _decodeResponse(response);

    debugPrint('Save profile: ${_message(data)}');

    return response.statusCode == 200 && data['success'] == true;
  }

  // ============================================================
  // UPDATE EXISTING USER PROFILE
  // ============================================================

  static Future<Map<String, dynamic>> updateUserProfile({
    required String userId,
    String? name,
    int? age,
    DateTime? dateOfBirth,
    String? gender,
    String? phone,
    String? countryCode,
    double? height,
    double? weight,
    String? profileImage,
  }) async {
    final Map<String, dynamic> body = {};

    if (name != null) {
      body['name'] = name;
    }

    if (age != null) {
      body['age'] = age;
    }

    if (dateOfBirth != null) {
      body['date_of_birth'] = dateOfBirth.toIso8601String().split('T').first;
    }

    if (gender != null) {
      body['gender'] = gender;
    }

    if (phone != null) {
      body['phone'] = phone;
    }

    if (countryCode != null) {
      body['country_code'] = countryCode;
    }

    if (height != null) {
      body['height'] = height;
    }

    if (weight != null) {
      body['weight'] = weight;
    }

    if (profileImage != null) {
      body['profile_image'] = profileImage;
    }

    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    final data = _decodeResponse(response);

    debugPrint('Update profile: ${_message(data)}');

    return {
      'success': response.statusCode == 200 && data['success'] == true,
      'message': _message(data),
    };
  }
}
