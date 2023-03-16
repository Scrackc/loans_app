import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loan_app/models/models.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  AuthInterceptor(this.storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.read(key: 'token');
    options.headers['Content-Type'] = 'application/json';
    options.headers['Authorization'] = 'Bearer $token';
    return super.onRequest(options, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    
    if (err.response != null) {
      final responseData = err.response?.data;
      final errorMessage = responseData['message'];
      final newError = DioError(
        response: err.response,
        error: errorMessage ?? 'An unknown error occurred.',
        type: err.type,
        requestOptions: err.requestOptions,
      );
      return handler.reject(newError);
    }
    handler.next(err);
  }
}
