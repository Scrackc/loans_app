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

  Future<Loan?> _getLoan(String id) async {
    final loanSearch = await _cache.getOne('/loan/$id');

    if (loanSearch != null) {
      return loanSearch;
    }
    try {
      final resp = await _dio.get('/loan/$id');

      final respJson = Loan.fromJson(resp.data);
      await _cache.add(respJson, '/loan/$id', const Duration(seconds: 15));
      await Future.delayed(Duration(seconds: 2));

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
      if(isActive) notifyListeners();

      return loan;
    }
    error = 'Error desconocido';
    isError = true;
  }

  Future saveLoan() async {}

  Future updateLoan(String productId, int quantity) async {
    final Map authData = {'idProduct': productId, 'quantity': quantity};
    try {
      final resp =
          await _dio.patch('/loan/${loan.id}', data: json.encode(authData));

      final product =
          loan.details!.firstWhere((element) => element.productId == productId);

      product.remainingQuantity -= quantity;

      // await loadLoan(loan.id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
