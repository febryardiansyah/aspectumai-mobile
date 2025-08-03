import 'package:aspectumai/core/models/user_model.dart';

class ChatSessionModel {
  final String? name;
  final List<dynamic>? messages;
  final UserModel? user;
  final String? createdAt;
  final String? updatedAt;
  final String? id;

  ChatSessionModel({
    this.name,
    this.messages,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory ChatSessionModel.fromJson(Map<String, dynamic> json) {
    return ChatSessionModel(
      name: json['name'] as String?,
      messages: json['messages'] as List<dynamic>?,
      user: json['user'] != null ? UserModel.fromJson(json['user'] as Map<String, dynamic>) : null,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'messages': messages,
      'user': user?.toJson(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'id': id,
    };
  }
}
