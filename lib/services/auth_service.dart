import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loan_app/utils/dio_instance.dart';
import 'dart:convert';

import '../models/models.dart';

class AuthService extends ChangeNotifier {
  
  final Dio _dio = DioInstance().dio;

  final storage = const FlutterSecureStorage();

  // Future<String?> createUser(String email, String password) async {
  //   final Map<String, dynamic> authData = {
  //     'email': email,
  //     'password': password,
  //     'returnSecureToken': true
  //   };
  //   final url =
  //       Uri.https(_baseUrl, '/auth');

  //   final resp = await http.post(url, body: json.encode(authData));

  //   final Map<String, dynamic> decodeResp = json.decode(resp.body);

  //   if (decodeResp.containsKey('idToken')) {
  //     await storage.write(key: 'token', value: decodeResp['idToken']);
  //     return null;
  //   }
  //   return decodeResp['error']['message'];
  // }

  Future<String?> login(String email, String password) async {
    
    try {
      final resp = await _dio.post(
        '/auth',
        data: {
          'email': email, 'password': password
        },
      );

        final decodeResp = Login.fromJson(resp.data);
        await storage.write(key: 'token', value: decodeResp.token);
      
    }on DioError catch(e){
      return e.error.toString();
    } catch (e) {
      // Network Error
      return 'Error en la red';
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
