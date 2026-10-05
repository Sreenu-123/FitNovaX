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
  // CREATE USER PROFILE
  // ============================================

  static Future<bool> createUserProfile({
    required String userId,
    required String name,
    required int age,
    required String gender,
    required double height,
    required double weight,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'name': name,
        'age': age,
        'gender': gender,
        'height': height,
        'weight': weight,
      }),
    );

    print(response.statusCode);
    print(response.body);

    return response.statusCode == 200;
  }
}
