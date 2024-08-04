import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/routes.dart'; // Asegúrate de importar tus rutas
import 'api/auth_service.dart'; // Importa AuthService
import 'api/api_service.dart';
import 'pages/login_page.dart'; // Asegúrate de importar tu página de login
import 'pages/dashboard_page.dart'; // Asegúrate de importar tu página de dashboard

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthService(ApiService('http://10.0.2.2:3000')),
      child: Consumer<AuthService>(
        builder: (context, authService, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'LeafApp',
            initialRoute: authService.isAuthenticated ? 'dashboard' : 'home',
            routes: appRoutes,
          );
        },
      ),
    );
  }
}
