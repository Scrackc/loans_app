// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

import 'models.dart';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    required this.users,
  });

  List<User> users;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
