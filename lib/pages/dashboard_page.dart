import 'package:flutter/material.dart';
import 'package:leafapp/widgets/leaf_app_bar.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatelessWidget {
  final String apiBaseUrl = 'http://10.0.2.2:3000';

  Future<void> logout(BuildContext context) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/api/logout'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    } else {
      // Maneja el error según sea necesario
      print('Logout failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        logoPath: 'assets/loguito.png',
        buttonText: 'Dashboard', // Puedes cambiar esto según lo necesites
        onButtonPressed: () => logout(context),
      ),
      backgroundColor: const Color(0xFF5e9a42),
      body: Center(
        child: ElevatedButton(
          onPressed: () => logout(context), // Llama a la función de logout
          child: Text('Logout'),
        ),
      ),
    );
  }
}
