import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waste_friendly/models/ativity_controller.dart';
import 'package:waste_friendly/models/point_model.dart';
import 'package:waste_friendly/models/user_model.dart';
import 'package:waste_friendly/services/storage_service.dart';
import 'package:waste_friendly/models/schedule_pickup.dart';

class ApiService {
  static const String baseUrl = 'https://pay1.jetdev.life';
  final StorageService _storageService = StorageService();

  // Login user
  Future<User?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/account/login'),
      body: jsonEncode({'username': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body));
      if (user.token != null) {
        await _storageService.saveToken(user.token!); // Save token
      }
      return user;
    }
    return null;
  }

  // Register user
  Future<bool> register(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/account/register'),
      body: jsonEncode(user.toJson()), // Includes password in the payload
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }

  // Fetch activities
  Future<List<Activity>> fetchActivity(int limit) async {
    final token = await _storageService.getToken(); // Get the token from storage

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/account/activity?limit=$limit'),
      headers: {'Authorization': 'Bearer $token'}, // Use token for authorization
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body); // Decode response
      return data.map((item) => Activity.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load activity data');
    }
  }

  // Create schedule for pickup
  Future<bool> createSchedulePickup(String token, SchedulePickup schedule) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/account/schedule'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(schedule.toJson()),
    );

    print(response.body); // For checking response
    return response.statusCode == 200;
  }

  // Fetch points data
  Future<PointsModel> fetchPoints() async {
    final token = await _storageService.getToken(); // Get token from storage

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/account/points'),
      headers: {'Authorization': 'Bearer $token'}, // Use token for authorization
    );

    if (response.statusCode == 200) {
      // Parse the JSON response and return PointsModel
      return PointsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load points data');
    }
  }
}
