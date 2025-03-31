import 'package:flutter/material.dart';
import 'package:waste_friendly/models/history_pickup.dart';
import 'package:waste_friendly/services/api_service.dart';  

class HistoryController {
  final ApiService _apiService = ApiService();

  // Fetch Pickup data using the ApiService
  Future<List<HistoryModel>> fetchPickup() async {
    try {
      return await _apiService.fetchPickupHistory();
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
   // Cancel Pickup
  Future<bool> cancelPickup(int pickupId) async {
    try {
      return await _apiService.cancelPickup(pickupId);
    } catch (e) {
      return false; // Return false if API call fails
    }
  }
}