class SchedulePickup {
  final int id;
  final String userId;
  final DateTime pickupDate;
  final String pickupTime;
  final int deliveryWeek;
  final List<String> wasteTypes;
  final DateTime createdAt;

  SchedulePickup({
    required this.id,
    required this.userId,
    required this.pickupDate,
    required this.pickupTime,
    required this.deliveryWeek,
    required this.wasteTypes,
    required this.createdAt,
  });

  // Convert JSON to SchedulePickup
  factory SchedulePickup.fromJson(Map<String, dynamic> json) {
    return SchedulePickup(
      id: json['id'],
      userId: json['userId'],
      pickupDate: DateTime.parse(json['pickupDate']),
      pickupTime: json['pickupTime'],
      deliveryWeek: json['deliveryWeek'],
      wasteTypes: List<String>.from(json['wasteTypes']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Convert SchedulePickup to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'pickupDate': pickupDate.toIso8601String(),
      'pickupTime': pickupTime,
      'deliveryWeek': deliveryWeek,
      'wasteTypes': wasteTypes,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
