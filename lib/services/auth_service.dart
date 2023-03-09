import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/models.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = '192.168.1.93:3000';

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
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final url = Uri.http(_baseUrl, '/auth');
    try {
      final resp = await http.post(
        url,
        body: authData,
      );

      final Map<String, dynamic> loginMap = json.decode(resp.body);
      try {
        final decodeResp = Login.fromJson(loginMap);
         await storage.write(key: 'token', value: decodeResp.token);
         
      } catch (e) {
        final decodeResp = ErrorHttp.fromJson(loginMap);
        return decodeResp.message;
      }

    } catch (e) { // Network Error
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
