import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../api/auth_interceptor.dart';

class DioInstance {
  Dio _dio = Dio();
  final _storage = const FlutterSecureStorage();

  Dio get dio => _dio;

  DioInstance() {
    _dio.options.baseUrl = 'http://192.168.1.93:3000';
    // _dio.options.connectTimeout = 5000;
    // _dio.options.receiveTimeout = 3000;

    // Agregar interceptors aquí
    _dio.interceptors.add(AuthInterceptor(_storage));
  }
}
