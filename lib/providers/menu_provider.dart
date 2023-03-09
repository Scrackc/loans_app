import 'package:flutter/material.dart';
import 'package:loan_app/screens/screens.dart';

class MenuProvider extends ChangeNotifier {
  int _currentSelect = 1;

  Map<String, IconData>  menuItems = {
    'drawer': Icons.abc,
    HomeScreen.routerName: Icons.home_outlined,
    UsersScreen.routerName: Icons.person_outline,
    LoansScreen.routerName: Icons.payment_outlined,
    ProductsScreen.routerName: Icons.auto_awesome_outlined,
  };

  int get currentSelect => _currentSelect;

  set currentSelect(int value){
    _currentSelect = value;
    notifyListeners();
  }
}