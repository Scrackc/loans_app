import 'package:flutter/material.dart';
import 'package:loan_app/providers/providers.dart';
import 'package:loan_app/screens/screens.dart';
import 'package:loan_app/ui/input_decorations.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static String routerName = "login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const HeaderWave(),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: const _FormLogin(),
                ),
                const FooterWave(),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _FormLogin extends StatelessWidget {
  const _FormLogin();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            InputPadding(
              child: TextFormField(
                enabled: !loginForm.isLoading,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'john.doe@gmail.com',
                  labelText: 'Email',
                  suffixIcon: Icons.alternate_email,
                ),
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'El correo no es valido';
                },
                onChanged: (value) => loginForm.email = value,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InputPadding(
              child: TextFormField(
                enabled: !loginForm.isLoading,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '********',
                  labelText: 'Password',
                  suffixIcon: Icons.lock_outline,
                ),
                validator: (value) {
                  if (value != null && value.length < 6) return 'La contraseña debe tener al menos 6 caracteres';
                  return null;
                },
                onChanged: (value) => loginForm.password = value,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: loginForm.isLoading
                  ? null
                  : () async{
                      final navigator = Navigator.of(context);
                      FocusScope.of(context).unfocus();
                      final authService = Provider.of<AuthService>(context, listen: false);
                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = true;

                      final String? errorMessage = await authService.login(loginForm.email, loginForm.password);

                      if(errorMessage != null){
                        NotificationsService.showSnackbar(errorMessage);
                        loginForm.isLoading = false;
                      }else{
                        navigator.pushReplacementNamed(HomeScreen.routerName);
                      }

                    },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: const Color.fromRGBO(93, 240, 152, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
