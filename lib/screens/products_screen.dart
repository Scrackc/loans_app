import 'package:flutter/material.dart';
import 'package:loan_app/widgets/widgets.dart';

class ProductsScreen extends StatelessWidget {

  static String routerName = 'Products';

   
  const ProductsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
         child: Text('ProductsScreen'),
      ),
       drawer: SideMenu(),
    );
  }
}