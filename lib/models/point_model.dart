class PointsModel {
  final int totalPoints;
  final double cashEquivalent;

  PointsModel({required this.totalPoints, required this.cashEquivalent});

  // Factory method to create an instance of PointsModel from JSON
  factory PointsModel.fromJson(Map<String, dynamic> json) {
    return PointsModel(
      totalPoints: json['totalPoints'],
      cashEquivalent: json['cashEquivalent'].toDouble(),
    );
  }

  // Method to convert PointsModel into a map (for requests if needed)
  Map<String, dynamic> toJson() {
    return {
      'totalPoints': totalPoints,
      'cashEquivalent': cashEquivalent,
    };
  }
}
