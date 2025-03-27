

import 'package:waste_friendly/services/api_service.dart';
import 'package:waste_friendly/models/ativity_controller.dart';

class ActivityController {
  final ApiService _apiService = ApiService();

  Future<List<Activity>> fetchActivity() {
    return _apiService.fetchActivity(20);
  }
}
