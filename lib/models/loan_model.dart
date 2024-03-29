// To parse this JSON data, do
//
//     final loans = loansFromJson(jsonString);

import 'dart:convert';

import 'package:loan_app/models/models.dart';

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
    this.details,
    this.moves,
  });

  String id;
  DateTime date;
  bool isComplete;
  User client;
  User user;
  List<Detail>? details;
  List<Move>? moves;

  factory Loan.fromRawJson(String str) => Loan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Loan.fromJson(Map<String, dynamic> json) => Loan(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        isComplete: json["isComplete"],
        client: User.fromJson(json["client"]),
        user: User.fromJson(json["user"]),
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
        moves: json["moves"] == null
            ? []
            : List<Move>.from(json["moves"]!.map((x) => Move.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "isComplete": isComplete,
        "client": client.toJson(),
        "user": user.toJson(),
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
        "moves": moves == null
            ? []
            : List<dynamic>.from(moves!.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    required this.loanId,
    required this.productId,
    required this.quantity,
    required this.remainingQuantity,
    required this.product,
  });

  String loanId;
  String productId;
  int quantity;
  int remainingQuantity;
  Product product;

  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        loanId: json["loanId"],
        productId: json["productId"],
        quantity: json["quantity"],
        remainingQuantity: json["remainingQuantity"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "loanId": loanId,
        "productId": productId,
        "quantity": quantity,
        "remainingQuantity": remainingQuantity,
        "product": product.toJson(),
      };
}

class Move {
  Move({
    required this.id,
    required this.quantity,
    required this.date,
    required this.loanId,
    required this.productId,
    required this.product,
    required this.user,
  });

  int id;
  int quantity;
  DateTime date;
  String loanId;
  String productId;
  Product product;
  User user;

  factory Move.fromRawJson(String str) => Move.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Move.fromJson(Map<String, dynamic> json) => Move(
        id: json["id"],
        quantity: json["quantity"],
        date: DateTime.parse(json["date"]),
        loanId: json["loanId"],
        productId: json["productId"],
        product: Product.fromJson(json["product"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "date": date.toIso8601String(),
        "loanId": loanId,
        "productId": productId,
        "product": product.toJson(),
        "user": user.toJson(),
      };
}
