import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waste_friendly/models/user_model.dart';
import 'package:waste_friendly/services/storage_service.dart';
import 'package:waste_friendly/models/schedule_pickup.dart';

class ApiService {
  static const String baseUrl = 'https://pay1.jetdev.life';
  final StorageService _storageService = StorageService();

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

  Future<bool> register(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/account/register'),
      body: jsonEncode(user.toJson()), // Includes password in the payload
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }

  // Corrected the incomplete code for `http.get`
  Future<List<dynamic>> fetchActivity(String token, int limit) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/account/activity?limit=$limit'),
      headers: {'Authorization': 'Bearer $token'}, // Use token
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return the list of activities from the response
    } else {
      throw Exception('Failed to load activity data');
    }
  }
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


}
