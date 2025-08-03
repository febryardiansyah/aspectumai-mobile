class LoginResponseModel {
  final String? id;
  final String? name;
  final String? email;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isEmailVerified;
  final String? token;
  final String? username;

  const LoginResponseModel({
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.isEmailVerified,
    this.token,
    this.username,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isEmailVerified: json['isEmailVerified'],
      token: json['token'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isEmailVerified': isEmailVerified,
      'token': token,
      'username': username,
    };
  }
}
