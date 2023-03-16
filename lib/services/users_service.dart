import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:loan_app/utils/dio_instance.dart';

import '../models/models.dart';

class UsersService extends ChangeNotifier {
  
  final Dio _dio = DioInstance().dio;

  Future<List<User>> loadUsers() async {
    
    final resp = await _dio.get('/users');
    
    final respJson = Users.fromJson(resp.data);
    // return respJson.users.map((e) => e.name);
    print('me acrive');
    return respJson.users;
  }
}
