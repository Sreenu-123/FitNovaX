import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  // ============================================
  // TEST BACKEND CONNECTION
  // ============================================

  static Future<void> testConnection() async {
    final response = await http.get(Uri.parse('$baseUrl/health'));

    print(response.statusCode);
    print(response.body);
  }

  // ============================================
  // SIGN UP
  // ============================================

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

    print(response.statusCode);
    print(response.body);

    final data = jsonDecode(response.body);

    return {
      'success': response.statusCode == 201,
      'message': data['message'] ?? 'Something went wrong',
      'user_id': data['user_id'],
    };
  }

  // ============================================
  // LOGIN
  // ============================================

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print(response.statusCode);
    print(response.body);

    final data = jsonDecode(response.body);

    return {
      'success': data['success'] ?? false,
      'message': data['message'] ?? 'Something went wrong',
      'user_id': data['user_id'],
      'name': data['name'],
      'email': data['email'],
    };
  }

  // ============================================
  // FORGOT PASSWORD
  // ============================================

  static Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    print(response.statusCode);
    print(response.body);

    final data = jsonDecode(response.body);

    return {
      'success': data['success'] ?? false,
      'message': data['message'] ?? 'Something went wrong',
    };
  }

  // ============================================
  // RESET PASSWORD
  // ============================================

  static Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token, 'new_password': newPassword}),
    );

    print(response.statusCode);
    print(response.body);

    final data = jsonDecode(response.body);

    return {
      'success': data['success'] ?? false,
      'message': data['message'] ?? 'Something went wrong',
    };
  }

  // ============================================
  // GET USER PROFILE
  // ============================================

  static Future<Map<String, dynamic>> getUserProfile({
    required String userId,
  }) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));

    print(response.statusCode);
    print(response.body);

    final data = jsonDecode(response.body);

    return {
      'exists': data['exists'] ?? false,
      'user_id': data['user_id'],
      'name': data['name'],
      'age': data['age'],
      'date_of_birth': data['date_of_birth'],
      'gender': data['gender'],
      'phone': data['phone'],
      'country_code': data['country_code'],
      'height': data['height'],
      'weight': data['weight'],
      'profile_image': data['profile_image'],
      'message': data['message'],
    };
  }

  // ============================================
  // CREATE USER PROFILE
  // ============================================

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

    print(response.statusCode);
    print(response.body);

    return response.statusCode == 200;
  }
}
