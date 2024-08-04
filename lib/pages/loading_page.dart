import 'package:flutter/material.dart';
import '../widgets/leaf_app_bar.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

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
