import 'package:flutter/material.dart';
import '../widgets/leaf_app_bar.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        logoPath: 'assets/loguito.png',
        buttonText: 'Login',
        onButtonPressed: () {},
      ),
      body: const Center(
        child: Text('Loading'),
      ),
    );
  }
}
