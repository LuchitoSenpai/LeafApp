import 'package:flutter/material.dart';
import '../widgets/leaf_app_bar.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF5e9a42),
        appBar: CustomAppBar(
          logoPath: 'assets/loguito.png',
          buttonText: 'Home',
          onButtonPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, 'home', (route) => false);
          },
        ),
        body: Center(
          child: LoginForm(),
        ));
  }
}
