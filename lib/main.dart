import 'package:flutter/material.dart';
import 'package:loan_app/providers/providers.dart';
import 'package:loan_app/screens/screens.dart';
import 'package:provider/provider.dart';

import 'services/services.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => MenuProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoansService(),
        ),
        ChangeNotifierProvider(
          create: (_) => UsersService(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        useMaterial3: true,
      ),
      scaffoldMessengerKey: NotificationsService.messengerKey,
      title: 'loans app',
      initialRoute: HomeScreen.routerName,
      routes: {
        LoginScreen.routerName: (_) => const LoginScreen(),
        HomeScreen.routerName: (_) => const HomeScreen(),
        UsersScreen.routerName: (_) => const UsersScreen(),
        LoansScreen.routerName: (_) => const LoansScreen(),
        ProductsScreen.routerName: (_) => const ProductsScreen(),
        LoanScreen.routerName: (_) => const LoanScreen(),
        NewLoanScreen.routerName: (_) => const NewLoanScreen(),
      },
    );
  }
}
