import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loan_app/models/models.dart';
import 'package:http/http.dart' as http;

class LoansService extends ChangeNotifier {
  final _baseUrl = '192.168.1.68:3000';

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
    try {
      final url = Uri.http(_baseUrl, 'loan');
      final resp = await http.get(url);
      final Map<String, dynamic> loansMap = json.decode(resp.body);
      try {
        final respJson = Loans.fromJson(loansMap);
        return respJson.loans;
      } catch (e) {
        final decodeResp = ErrorHttp.fromJson(loansMap);
        isError = true;
        error = decodeResp.message;
        return [];
      }
    } catch (e) {
      print(e);
      isError = true;
      error = 'Error desconocido';
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
