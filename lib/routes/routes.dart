import 'package:flutter/material.dart';
import 'package:leafapp/pages/dashboard_page.dart';
import 'package:leafapp/pages/home_page.dart';
import 'package:leafapp/pages/loading_page.dart';
import 'package:leafapp/pages/login_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login': (_) => LoginPage(),
  'loading': (_) => LoadingPage(),
  'home': (_) => HomePage(),
  'dashboard': (_) => DashboardPage()
};
