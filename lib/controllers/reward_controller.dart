import 'package:waste_friendly/models/reward_model.dart';
import 'package:waste_friendly/services/api_service.dart';


class RewardController {
  final ApiService _apiService = ApiService();

  Future<List<RewardModel>> fetchReward() {
    return _apiService.fetchReward();
  }
}