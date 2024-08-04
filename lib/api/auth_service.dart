import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'api_service.dart';

class AuthService extends ChangeNotifier {
  final ApiService _apiService;
  bool _isAuthenticated =
      false; // Añadido para manejar el estado de autenticación

  AuthService(this._apiService);

  bool get isAuthenticated =>
      _isAuthenticated; // Getter para verificar autenticación

  Future<Map<String, dynamic>?> login(String email, String password) async {
    print('Making POST request to: ${_apiService.baseUrl}/login');
    print(
        'Request body: ${jsonEncode({'email': email, 'password': password})}');

    try {
      final response = await _apiService.post(
        'api/login',
        {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        _isAuthenticated = true; // Establece el estado de autenticación
        notifyListeners(); // Notifica a los listeners para actualizar la UI
        return responseBody;
      } else {
        print('Login failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  Future<void> logout() async {
    print('Making POST request to: ${_apiService.baseUrl}/logout');

    try {
      final response = await _apiService.post('api/logout', {});

      if (response.statusCode == 200) {
        _isAuthenticated = false; // Cambia el estado de autenticación
        notifyListeners(); // Notifica a los listeners para actualizar la UI
      } else {
        print('Logout failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
