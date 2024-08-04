import 'package:flutter/material.dart';
import 'package:leafapp/widgets/leaf_app_bar.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        logoPath: 'assets/loguito.png',
        buttonText: 'Logout',
        onButtonPressed: () {
          Navigator.pushNamed(context,
              'home'); // Navega a la pantalla de login después del logout
        },
        logoutUrl: 'http://10.0.2.2:3000/api/logout', // La URL de logout
      ),
      backgroundColor: const Color(0xFF5e9a42),
      body: Center(
        child: Text('Dashboard'),
      ),
    );
  }
}
