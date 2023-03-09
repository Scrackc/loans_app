import 'package:flutter/material.dart';
import 'package:loan_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static String routerName = 'Home';
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home screen"),
      ),
      body: const Center(
         child: Text('Deposito'),
      ),
      drawer: SideMenu(),
    );
  }
}