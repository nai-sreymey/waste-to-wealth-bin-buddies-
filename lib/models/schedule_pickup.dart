class SchedulePickup {
  final int id;
  final String userId;
  final DateTime pickupDate;
  final String pickupTime;
  final double pickupWeight; // Added pickupWeight field
  final int deliveryWeek;
  final List<String> wasteTypes;
  final DateTime createdAt;

  SchedulePickup({
    required this.id,
    required this.userId,
    required this.pickupDate,
    required this.pickupTime,
    required this.pickupWeight, // Added pickupWeight to constructor
    required this.deliveryWeek,
    required this.wasteTypes,
    required this.createdAt,
  });

  // Convert JSON to SchedulePickup
  factory SchedulePickup.fromJson(Map<String, dynamic> json) {
    return SchedulePickup(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 'Unknown',
      pickupDate: DateTime.parse(json['pickupDate'] ?? DateTime.now().toIso8601String()),
      pickupTime: json['pickupTime'] ?? 'Not Available',  // Fallback to 'Not Available'
      pickupWeight: json['pickupWeight']?.toDouble() ?? 0.0, // Ensure weight is a double
      deliveryWeek: json['deliveryWeek'] ?? 1,  // Default to week 1 if not available
      wasteTypes: List<String>.from(json['wasteTypes'] ?? []),  // Default to empty list
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()), // Default to current date if not available
    );
  }

  // Convert SchedulePickup to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'pickupDate': pickupDate.toIso8601String(),
      'pickupTime': pickupTime,
      'pickupWeight': pickupWeight, // Include weight in the output
      'deliveryWeek': deliveryWeek,
      'wasteTypes': wasteTypes,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
