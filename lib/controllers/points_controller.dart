import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:waste_friendly/services/api_service.dart';
import 'package:waste_friendly/models/point_model.dart';

class PointsController with ChangeNotifier {
  final ApiService _service = ApiService(); // Use the correct ApiService
  late PointsModel _points;
  bool _isLoading = false;

  // Getter for Points
  PointsModel get points => _points;

  // Getter for loading state
  bool get isLoading => _isLoading;

  // Function to fetch points data from the service
  Future<void> fetchPointsData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Corrected function call to fetch points from ApiService
      _points = await _service.fetchPoints();
    } catch (e) {
      // Handle error appropriately
      log('Error fetching points data: $e');
      throw Exception('Error fetching points data');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
