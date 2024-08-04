import 'package:flutter/material.dart';
import '../widgets/leaf_app_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5e9a42),
      appBar: CustomAppBar(
        logoPath: 'assets/loguito.png',
        buttonText: 'Login',
        onButtonPressed: () {
          Navigator.pushNamed(context, 'login');
        },
      ),
      body: const Center(
        child: Text(
          'Welcome',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 40,
            color: Color(0xFFEBF8E4),
          ),
        ),
      ),
    );
  }
}
