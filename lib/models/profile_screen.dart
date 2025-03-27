class ProfileModel {
  final String userName;
  final String email;
  final String profileImageUrl;
  final String phone;
  final String address;

  ProfileModel({
    required this.userName,
    required this.email,
    required this.profileImageUrl,
    required this.phone,
    required this.address,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userName: json['userName'] ?? 'Unknown',
      email: json['email'] ?? 'No Email',
      profileImageUrl: json['profileImageUrl'] ?? '',
      phone: json['phone'] ?? 'N/A',
      address: json['address'] ?? 'N/A',
    );
  }
}