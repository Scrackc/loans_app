import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loan_app/models/models.dart';

import 'package:loan_app/utils/dio_instance.dart';

import 'cache_service.dart';

class LoanService extends ChangeNotifier {
  final Dio _dio = DioInstance().dio;
  final _cache = CrudCacheService<Loan>(fromJson: Loan.fromJson);

  // Containers
  late final Loan loan;
  final String idLoan;

  // control of state
  bool isLoading = true;
  bool isError = false;
  bool isActive = true;
  String error = '';

  LoanService(this.idLoan) {
    loadLoan(idLoan);
  }

  void changeActive() {
    isActive = false;
  }

  Future _saveCache(Loan loanSave, String id) async {
    await _cache.add(loanSave, '/loan/$id', const Duration(seconds: 60));
  }

  Future<Loan?> _getLoan(String id) async {
    final loanSearch = await _cache.getOne('/loan/$id');

    if (loanSearch != null) {
      return loanSearch;
    }
    try {
      final resp = await _dio.get('/loan/$id');
      final respJson = Loan.fromJson(resp.data);
      print(respJson.isComplete);

      await _saveCache(respJson, id);

      return respJson;
    } catch (e) {
      return null;
    }
  }

  Future loadLoan(String id) async {
    isLoading = true;
    notifyListeners();

    final loanSearch = await _getLoan(id);
    if (loanSearch != null) {
      loan = loanSearch;
      isLoading = false;
      if (isActive) notifyListeners();

      return loan;
    }
    error = 'Error desconocido';
    isError = true;
  }

  Future updateLoan(String productId, int quantity) async {
    final Map authData = {'idProduct': productId, 'quantity': quantity};
    try {
      final resp = await _dio.patch('/loan/${loan.id}', data: json.encode(authData));

      final product = loan.details!.firstWhere((element) => element.productId == productId);

      product.remainingQuantity -= quantity;
      await _saveCache(loan, loan.id);
      notifyListeners();

      final loanSearch = await _getLoan(loan.id);
      if(loanSearch != null){
        print(loanSearch.isComplete);
        // loan.details = loanSearch.details;
        loan.isComplete = loanSearch.isComplete;
        notifyListeners();
      }


    } catch (e) {
      print(e);
    }
  }
}
