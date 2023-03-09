
import 'dart:convert';

class Login {
  Login({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.token,
    required this.refreshToken,
  });

  String id;
  String name;
  String email;
  String role;
  String token;
  String refreshToken;

  factory Login.fromRawJson(String str) => Login.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        token: json["token"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "token": token,
        "refreshToken": refreshToken,
      };
}
