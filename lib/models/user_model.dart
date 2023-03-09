import 'dart:convert';

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    this.address,
    required this.role,
    required this.createAt,
    required this.updateAt,
  });

  String id;
  String name;
  String email;
  dynamic address;
  String role;
  DateTime createAt;
  DateTime updateAt;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        role: json["role"],
        createAt: DateTime.parse(json["createAt"]),
        updateAt: DateTime.parse(json["updateAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address,
        "role": role,
        "createAt": createAt.toIso8601String(),
        "updateAt": updateAt.toIso8601String(),
      };
}
