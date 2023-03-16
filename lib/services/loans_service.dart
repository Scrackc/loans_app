import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loan_app/models/models.dart';
import 'package:loan_app/utils/dio_instance.dart';
// import 'dart:typed_data';

import 'cache_service.dart';

class LoansService extends ChangeNotifier {
  final Dio _dio = DioInstance().dio;

  final _cache = CrudCacheService<Loan>(fromJson: Loan.fromJson);

  // Containers
  final List<Loan> loans = [];

  // control of state
  bool isLoading = true;
  bool isError = false;
  String error = '';

  LoansService() {
    loadLoans();
  }

 

  Future<List<Loan>> _getLoans() async {
    final loans = await _cache.getAll('/loans');
    if (loans.isNotEmpty) {
      return loans;
    }

    try {
      final resp = await _dio.get('/loan');
      final respJson = Loans.fromJson(resp.data);
      await _cache.addList(respJson.loans, '/loans', const Duration(seconds: 10));

      return respJson.loans;
      
    } on DioError catch (e) {
      error = e.error.toString();
      isError = true;
      return [];
    }catch (e){
      error = 'Error desconocido';
      isError = true;
      return [];
    }
  }

  Future<List<Loan>> loadLoans() async {
    isLoading = true;
    notifyListeners();

    final loansResp = await _getLoans();

    loans.addAll(loansResp);
    isLoading = false;
    notifyListeners();
    // verificar alojamiento
    return loansResp;
  }

  Future refreshLoans() async {
    isError = false;
    error = '';
    notifyListeners();
    final loansResp = await _getLoans();
    loans.clear();
    loans.addAll(loansResp);
    notifyListeners();
  }

}
