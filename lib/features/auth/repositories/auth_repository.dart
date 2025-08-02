import 'package:aspectumai/core/models/meta_model.dart';
import 'package:aspectumai/core/network/dio_client.dart';
import 'package:aspectumai/features/auth/models/login_response_model.dart';
import 'package:aspectumai/features/auth/utils/auth_utils.dart';
import 'package:dio/dio.dart';

abstract class IAuthRepository {
  Future<LoginResponseModel> login(String email, String password);
  Future<String> register(String fullname, String username, String email, String password);
  Future<String> emailVerification({
    required String email,
    required EmailVerificationType type,
  });
  Future<String> resendOTP(String email);
  Future<String> verifyOTP(String email, String otp);
  Future<String> resetPassword(String email, String password, String otp);
  Future<void> logout();
}

class AuthRepository implements IAuthRepository {
  final DioClient _client;

  AuthRepository(DioClient client) : _client = client;

  @override
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final response = await _client.post(
        '/auth/sign-in',
        data: {
          'email': email,
          'password': password,
        },
      );

      return LoginResponseModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw e.error.toString();
    }
  }
  
  @override
  Future<String> register(String fullname, String username, String email, String password) async {
    try {
      final response = await _client.post(
        '/auth/sign-up',
        data: {
          "name": fullname,
          "last_name": "",
          "username": username,
          "email": email,
          "password": password,
        },
      );

      final data = MetaModel.fromJson(response.data['meta']);

      return data.message ?? '';
    } on DioException catch (e) {
      throw e.error.toString();
    }
  }

  @override
  Future<void> logout() async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<String> emailVerification({
    required String email,
    required EmailVerificationType type,
  }) async {
    try {
      final response = await _client.post(
        'auth/email-verification',
        data: {
          'email': email,
          'type': type.value,
        },
      );

      final data = MetaModel.fromJson(response.data['meta']);

      return data.message ?? '';
    } on DioException catch (e) {
      throw e.error.toString();
    }
  }

  @override
  Future<String> verifyOTP(String email, String otp) async {
    try {
      final response = await _client.post(
        'auth/verify-otp',
        data: {
          'email': email,
          'otp': otp,
        },
      );

      final data = MetaModel.fromJson(response.data['meta']);

      return data.message ?? '';
    } on DioException catch (e) {
      throw e.error.toString();
    }
  }

  @override
  Future<String> resendOTP(String email) async {
    try {
      final response = await _client.post(
        'auth/resend-otp',
        data: {
          'email': email,
        },
      );

      final data = MetaModel.fromJson(response.data['meta']);

      return data.message ?? '';
    } on DioException catch (e) {
      throw e.error.toString();
    }
  }

  @override
  Future<String> resetPassword(String email, String password, String otp) async {
    try {
      final response = await _client.post(
        'auth/reset-password',
        data: {
          'email': email,
          'password': password,
          'otp': otp,
        },
      );

      final data = MetaModel.fromJson(response.data['meta']);

      return data.message ?? '';
    } on DioException catch (e) {
      throw e.error.toString();
    }
  }

}
