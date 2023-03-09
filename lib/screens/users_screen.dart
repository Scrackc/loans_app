import 'package:flutter/material.dart';
import 'package:loan_app/widgets/widgets.dart';

class UsersScreen extends StatelessWidget {

  static String routerName = 'Users';
   
  const UsersScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
         child: Text('UsersScreen'),
      ),
       drawer: SideMenu(),
    );
  }
}