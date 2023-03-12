import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class UsersService extends ChangeNotifier {
  final _baseUrl = '192.168.1.68:3000';

  Future<List<User>> loadUsers() async {
    final url = Uri.http(_baseUrl, 'users');
    final resp = await http.get(url);
    final Map<String, dynamic> usersMap = json.decode(resp.body);
    final respJson = Users.fromJson(usersMap);
    // return respJson.users.map((e) => e.name);
    print('me acrive');
    return respJson.users;
  }
}
