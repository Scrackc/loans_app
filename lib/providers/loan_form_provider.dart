import 'package:flutter/material.dart';

class LoanFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _idClient = '';
  List<_Detail> details = [];

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  set idClient(String value) {
    print("change value");
    _idClient = value;
  }

  addDetails() {
    details.add(_Detail(quantity: 4, productId: 'abc'));
    notifyListeners();
  }
}

class _Detail {
  _Detail({
    required this.quantity,
    required this.productId,
  });

  int quantity;
  String productId;

  factory _Detail.fromJson(Map<String, dynamic> json) => _Detail(
        quantity: json["quantity"],
        productId: json["productId"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "productId": productId,
      };
}
