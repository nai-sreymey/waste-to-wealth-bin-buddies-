import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waste_friendly/models/ativity_controller.dart';
import 'package:waste_friendly/models/point_model.dart';
import 'package:waste_friendly/models/profile_screen.dart';
import 'package:waste_friendly/models/user_model.dart';
import 'package:waste_friendly/services/storage_service.dart';
import 'package:waste_friendly/models/schedule_pickup.dart';
import 'package:waste_friendly/models/history_pickup.dart';
import 'package:waste_friendly/models/reward_model.dart';

class ApiService {
  static const String baseUrl = 'https://pay1.jetdev.life';
  final StorageService _storageService = StorageService();

  // Login user
  Future<User?> login(String email, String password) async {
    try {
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
      } else {
        print("Login failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error logging in: $e");
      throw Exception('Login failed');
    }
  }

  // Register user
  Future<bool> register(User user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/account/register'),
        body: jsonEncode(user.toJson()), // Includes password in the payload
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error registering: $e");
      throw Exception('Registration failed');
    }
  }

  // Fetch activities
  Future<List<Activity>> fetchActivity(int limit) async {
    final token = await _storageService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/account/activity?limit=$limit'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Activity.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load activity data');
    }
  }

  // Create schedule pickup
  Future<bool> createSchedulePickup(String token, SchedulePickup schedule) async {
    try {
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
    } catch (e) {
      print("Error scheduling pickup: $e");
      throw Exception('Failed to create schedule pickup');
    }
  }

  // Fetch history pickups
  Future<List<HistoryModel>> fetchPickupHistory() async {
    final token = await _storageService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/pickup/history'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => HistoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pickup history');
    }
  }

  // Cancel a pickup
  Future<bool> cancelPickup(int pickupId) async {
    final token = await _storageService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/pickup/cancel/$pickupId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      return response.statusCode == 200;
    } catch (error) {
      throw Exception('Failed to cancel pickup: $error');
    }
  }

  // Fetch reward data
  Future<List<RewardModel>> fetchReward() async {
    final token = await _storageService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/reward/listReward'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => RewardModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reward data');
    }
  }

  // Fetch points data
  Future<PointsModel> fetchPoints() async {
    final token = await _storageService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/account/points'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return PointsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load points data');
    }
  }

  // Fetch profile data
  Future<ProfileModel> fetchProfile() async {
    final token = await _storageService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/account/user'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return ProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile data');
    }
  }
}
