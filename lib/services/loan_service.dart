import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loan_app/models/models.dart';
import 'package:http/http.dart' as http;


class LoanService extends ChangeNotifier{
   final _baseUrl = '192.168.1.93:3000';

  // Containers
  late final SingleLoan loan;
  final String idLoan;

  // control of state
  bool isLoading = true;
  bool isError = false;
  String error = '';

  LoanService(this.idLoan){
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

  Future saveLoan()async{

  }

  Future updateLoan(String productId, int quantity )async{
    final product = loan.details.firstWhere((element) => element.productId == productId);
    product.remainingQuantity -= quantity; 
    loan.client.name = 'Abelardo';
    notifyListeners();
  }

}