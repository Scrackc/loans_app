import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:loan_app/utils/dio_instance.dart';

import '../models/models.dart';

class UsersService extends ChangeNotifier {
  final Dio _dio = DioInstance().dio;


  // Containers
  final List<User> users = [];

  bool isLoading = true;
  bool isError = false;
  String error = '';

  UsersService() {
    loadUsers();
  }
  
  Future<List<User>> loadUsers() async {
    isLoading = true;
    notifyListeners();
    final resp = await _dio.get('/users');

    final respJson = Users.fromJson(resp.data);
    users.addAll(respJson.users);
    isLoading = false;
    notifyListeners();

    return respJson.users;
  }
}
