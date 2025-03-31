class HistoryModel {
  final int pickupId;
  final String date;
  final List<String> wasteTypes;
  final String time; // Add this if missing
  final String weight; // Add this if missing
  final double pickupWeight;
  final String status;
  final String userId;
  final String? createdAt;

  HistoryModel({
    required this.pickupId,
    required this.date,
    required this.wasteTypes,
    required this.time,  // Add this if missing
    required this.weight,  // Add this if missing
    required this.pickupWeight,
    required this.status,
    required this.userId,
    this.createdAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      pickupId: json['pickupId'] ?? 0,
      date: json['date'] ?? '',
      wasteTypes: (json['wasteTypes'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      time: json['time'] ?? '',  // Add this line to parse time
      weight: json['weight'] ?? '',  // Add this line to parse weight
      pickupWeight: (json['pickupWeight'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? '',
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'],
    );
  }
}
