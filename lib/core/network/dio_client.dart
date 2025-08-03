import 'package:aspectumai/core/network/dio_interceptor.dart';
import 'package:dio/dio.dart';

class DioClient {
  late Dio _dio;

  DioClient({Dio? dio, bool isUnittest = false}) {
    _dio = dio ?? Dio();
    if (!isUnittest) _dio.interceptors.add(DioInterceptor());
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path, {Map<String, dynamic>? data}) async {
    return _dio.delete(path, data: data);
  }
}
