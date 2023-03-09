// To parse this JSON data, do
//
//     final loans = loansFromJson(jsonString);

import 'dart:convert';

import 'package:loan_app/models/user_model.dart';

class Loans {
  Loans({
    required this.loans,
  });

  List<Loan> loans;

  factory Loans.fromRawJson(String str) => Loans.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Loans.fromJson(Map<String, dynamic> json) => Loans(
        loans: List<Loan>.from(json["loans"].map((x) => Loan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "loans": List<dynamic>.from(loans.map((x) => x.toJson())),
      };
}

class Loan {
  Loan({
    required this.id,
    required this.date,
    required this.isComplete,
    required this.client,
    required this.user,
  });

  String id;
  DateTime date;
  bool isComplete;
  User client;
  User user;

  factory Loan.fromRawJson(String str) => Loan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Loan.fromJson(Map<String, dynamic> json) => Loan(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        isComplete: json["isComplete"],
        client: User.fromJson(json["client"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "isComplete": isComplete,
        "client": client.toJson(),
        "user": user.toJson(),
      };
  Loan copy() => Loan(client: client, id: id, date: date, isComplete: isComplete, user: user);
}
