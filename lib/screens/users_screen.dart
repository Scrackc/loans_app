import 'package:flutter/material.dart';
import 'package:loan_app/models/user_model.dart';
import 'package:loan_app/services/users_service.dart';
import 'package:loan_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  static String routerName = 'Users';

  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UsersService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: (userService.isLoading)
          ? const Center(child: CircularProgressIndicator.adaptive())
          : RefreshIndicator(
              onRefresh: () => Future.delayed(Duration(seconds: 3)),
              child: ListView.builder(
                itemCount: userService.users.length,
                itemBuilder: (context, index) {
                  final user = userService.users[index];
                  return _CardUser(user: user);
                },
              ),
            ),
      drawer: SideMenu(),
    );
  }
}

class _CardUser extends StatelessWidget {
  final User user;
  const _CardUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(user.name),
        trailing: Icon(Icons.arrow_forward_ios),
        subtitle: Text(user.email),
      ),
      
    );
  }
}
