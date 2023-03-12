import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loan_app/models/models.dart';
import 'package:http/http.dart' as http;

class LoanService extends ChangeNotifier {
  final _baseUrl = '192.168.1.68:3000';

  // Containers
  late final SingleLoan loan;
  final String idLoan;

  // control of state
  bool isLoading = true;
  bool isError = false;
  String error = '';

  LoanService(this.idLoan) {
    loadLoan(idLoan);
  }

  Future<SingleLoan> loadLoan(String id) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, 'loan/$id');
    final resp = await http.get(url);
    final Map<String, dynamic> loanMap = json.decode(resp.body);
    final respJson = SingleLoan.fromJson(loanMap);
    loan = respJson;
    // await Future.delayed(Duration(seconds: 2));
    isLoading = false;
    notifyListeners();
    return respJson;
  }

  Future saveLoan() async {}

  Future updateLoan(String productId, int quantity) async {
    final Map authData = {'idProduct': productId, 'quantity': quantity};
    try {
      final url = Uri.http(_baseUrl, 'loan/${loan.id}');
      final rp = await http.patch(url, body: json.encode(authData), headers: {
        "Content-Type": "application/json",
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjBmNzQxYWNlLWY2YzYtNDVlYy04OTc1LTY4MzBjZjdmYzNkZSIsImlhdCI6MTY3ODU5MzM4OSwiZXhwIjoxNjc4NjA3Nzg5fQ.06beMhkIOUqPFE3RhtDgZyX21TpvqRMvJbuZXW1kKDc'
      });

      final product =
          loan.details.firstWhere((element) => element.productId == productId);

      product.remainingQuantity -= quantity;

      // await loadLoan(loan.id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
