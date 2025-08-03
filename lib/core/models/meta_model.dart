class MetaModel {
  final bool? success;
  final int? code;
  final String? status;
  final String? message;

  MetaModel({
    this.success,
    this.code,
    this.status,
    this.message,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      success: json['success'] as bool?,
      code: json['code'] as int?,
      status: json['status'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'code': code,
      'status': status,
      'message': message,
    };
  }
}