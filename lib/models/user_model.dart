class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String profileImage;
  final String createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.profileImage,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id']?.toString() ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'] ?? '',
        address: json['address'] ?? '',
        profileImage: json['profile_image'] ?? '',
        createdAt: json['created_at'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'profile_image': profileImage,
        'created_at': createdAt,
      };
}