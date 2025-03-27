import 'dart:developer';
import 'package:waste_friendly/models/profile_screen.dart';
import 'package:waste_friendly/services/api_service.dart';

class ProfileController {
  final ApiService _apiService = ApiService();

  Future<ProfileModel> fetchProfile() {
    return _apiService.fetchProfile();
  }
}
