import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'session_service.dart';

class ProfilePersistenceService {
  // Android emulator: use http://10.0.2.2:8000
  // iOS simulator / same computer: use http://127.0.0.1:8000
  static const String _baseUrl = 'http://127.0.0.1:8000';

  static const Duration _timeout = Duration(seconds: 15);

  static String _goalKey(String userId) => 'fitnovax_goal_$userId';

  static String _imageKey(String userId) => 'fitnovax_profile_image_$userId';

  static Future<String?> _getUserId() async {
    final userId = await SessionService.getUserId();

    if (userId == null || userId.trim().isEmpty) {
      return null;
    }

    return userId.trim();
  }

  // Loads the profile for the currently logged-in user.
  static Future<Map<String, dynamic>> loadProfile({
    Map<String, dynamic> fallback = const {},
  }) async {
    final userId = await _getUserId();
    final result = Map<String, dynamic>.from(fallback);

    if (userId == null) {
      return result;
    }

    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http
          .get(
            Uri.parse('$_baseUrl/users/${Uri.encodeComponent(userId)}'),
            headers: const {'Accept': 'application/json'},
          )
          .timeout(_timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);

        if (decoded is Map<String, dynamic>) {
          final rawProfile = decoded['profile'];

          final Map<String, dynamic> data = rawProfile is Map<String, dynamic>
              ? rawProfile
              : decoded;

          if (decoded['exists'] != false && data.isNotEmpty) {
            result['name'] = data['name'] ?? result['name'] ?? '';

            result['email'] = data['email'] ?? result['email'] ?? '';

            result['age'] = _asText(data['age'] ?? result['age']);

            result['height'] = _asText(data['height'] ?? result['height']);

            result['weight'] = _asText(data['weight'] ?? result['weight']);

            result['gender'] = data['gender'] ?? result['gender'];

            result['dateOfBirth'] =
                data['date_of_birth'] ??
                data['dateOfBirth'] ??
                result['dateOfBirth'];

            result['phone'] = data['phone'] ?? result['phone'];

            result['countryCode'] =
                data['country_code'] ??
                data['countryCode'] ??
                result['countryCode'];

            // The locally saved permanent photo path is applied below.
            result['profileImagePath'] =
                data['profile_image'] ?? result['profileImagePath'];
          }
        }
      }
    } catch (_) {
      // If the server is unreachable, keep the available fallback data.
    }

    result['goal'] =
        prefs.getString(_goalKey(userId)) ?? result['goal'] ?? 'Build Muscle';

    // Prefer the permanent local image path.
    final savedImagePath = prefs.getString(_imageKey(userId));

    if (savedImagePath != null && savedImagePath.isNotEmpty) {
      final savedImage = File(savedImagePath);

      if (await savedImage.exists()) {
        result['profileImagePath'] = savedImage.path;
      } else {
        await prefs.remove(_imageKey(userId));
        result['profileImagePath'] = null;
      }
    }

    result['user_id'] = userId;

    return result;
  }

  // Copies a selected gallery image into the app's documents directory.
  static Future<String?> persistImage(String sourcePath) async {
    final userId = await _getUserId();

    if (userId == null) {
      throw Exception('No logged-in user was found. Please log in again.');
    }

    final source = File(sourcePath);

    if (!await source.exists()) {
      throw Exception('The selected image could not be found.');
    }

    final directory = await getApplicationDocumentsDirectory();

    final imageDirectory = Directory(
      '${directory.path}/fitnovax_profile_images',
    );

    if (!await imageDirectory.exists()) {
      await imageDirectory.create(recursive: true);
    }

    final safeId = userId.replaceAll(RegExp(r'[^a-zA-Z0-9_-]'), '_');

    final extension = _imageExtension(sourcePath);

    final targetPath = '${imageDirectory.path}/profile_$safeId$extension';

    // Avoid copying a file onto itself.
    if (source.absolute.path == File(targetPath).absolute.path) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(_imageKey(userId), targetPath);

      return targetPath;
    }

    final copiedImage = await source.copy(targetPath);

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_imageKey(userId), copiedImage.path);

    return copiedImage.path;
  }

  // Saves profile data and the permanent image path.
  static Future<bool> saveProfile(Map<String, dynamic> profile) async {
    final userId = await _getUserId();

    if (userId == null) {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();

    String? permanentImagePath;

    final imagePath = profile['profileImagePath']?.toString();

    if (imagePath != null && imagePath.isNotEmpty) {
      final imageFile = File(imagePath);

      if (await imageFile.exists()) {
        permanentImagePath = await persistImage(imagePath);
      }
    }

    // Keep the image path associated with this user.
    if (permanentImagePath != null) {
      await prefs.setString(_imageKey(userId), permanentImagePath);
    } else if (imagePath == null || imagePath.isEmpty) {
      await prefs.remove(_imageKey(userId));
    }

    await prefs.setString(
      _goalKey(userId),
      profile['goal']?.toString() ?? 'Build Muscle',
    );

    final body = <String, dynamic>{
      'user_id': userId,
      'name': (profile['name']?.toString() ?? '').trim(),
      'age': _asNumber(profile['age']),
      'height': _asNumber(profile['height']),
      'weight': _asNumber(profile['weight']),
      'gender': profile['gender'],
      'date_of_birth': profile['dateOfBirth'] ?? profile['date_of_birth'],
      'phone': profile['phone'],
      'country_code': profile['countryCode'] ?? profile['country_code'],
      // This is a local path, not a cloud URL.
      'profile_image': permanentImagePath,
    };

    body.removeWhere((key, value) => value == null || value == '');

    try {
      final profileUri = Uri.parse(
        '$_baseUrl/users/${Uri.encodeComponent(userId)}',
      );

      final existing = await http
          .get(profileUri, headers: const {'Accept': 'application/json'})
          .timeout(_timeout);

      late http.Response response;

      if (existing.statusCode == 404) {
        response = await http
            .post(
              Uri.parse('$_baseUrl/users'),
              headers: const {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
              body: jsonEncode(body),
            )
            .timeout(_timeout);
      } else if (existing.statusCode >= 200 &&
          existing.statusCode < 300 &&
          _profileExists(existing.body)) {
        response = await http
            .put(
              profileUri,
              headers: const {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
              body: jsonEncode(body),
            )
            .timeout(_timeout);
      } else {
        // Do not create or update blindly if the GET request failed.
        return false;
      }

      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (_) {
      return false;
    }
  }

  static bool _profileExists(String body) {
    try {
      final decoded = jsonDecode(body);

      if (decoded is Map<String, dynamic>) {
        if (decoded['exists'] is bool) {
          return decoded['exists'] as bool;
        }

        if (decoded['profile'] is Map) {
          return true;
        }

        return decoded.containsKey('user_id') || decoded.containsKey('name');
      }
    } catch (_) {
      // Invalid JSON cannot confirm that the profile exists.
    }

    return false;
  }

  static String _imageExtension(String path) {
    final extension = path.split('.').last.toLowerCase();

    const allowed = {'jpg', 'jpeg', 'png', 'webp', 'heic'};

    if (allowed.contains(extension)) {
      return '.$extension';
    }

    return '.jpg';
  }

  static String _asText(dynamic value) {
    return value == null ? '' : value.toString();
  }

  static num? _asNumber(dynamic value) {
    if (value == null) return null;

    if (value is num) return value;

    return num.tryParse(value.toString().trim());
  }
}
