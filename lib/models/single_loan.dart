// To parse this JSON data, do
//
//     final loan = loanFromJson(jsonString);

import 'dart:convert';

import 'package:loan_app/models/models.dart';

class SingleLoan {
  SingleLoan({
    required this.id,
    required this.date,
    required this.isComplete,
    required this.client,
    required this.user,
    required this.details,
  });

  String id;
  DateTime date;
  bool isComplete;
  User client;
  User user;
  List<Detail> details;

  factory SingleLoan.fromRawJson(String str) =>
      SingleLoan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SingleLoan.fromJson(Map<String, dynamic> json) => SingleLoan(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        isComplete: json["isComplete"],
        client: User.fromJson(json["client"]),
        user: User.fromJson(json["user"]),
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "isComplete": isComplete,
        "client": client.toJson(),
        "user": user.toJson(),
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
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
