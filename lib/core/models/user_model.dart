class UserModel {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? username;
  final String? email;
  final bool? isEmailVerified;

  UserModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.username,
    this.email,
    this.isEmailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name': name,
      'username': username,
      'email': email,
      'isEmailVerified': isEmailVerified,
    };
  }
}
