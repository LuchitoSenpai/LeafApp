import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart'; // Asegúrate de importar ApiService

class AuthService {
  final ApiService _apiService;

  AuthService(
      this._apiService); // Asegúrate de que ApiService se pase correctamente

  Future<Map<String, dynamic>?> login(String email, String password) async {
    print('Making POST request to: ${_apiService.baseUrl}/login');
    print(
        'Request body: ${jsonEncode({'email': email, 'password': password})}');

    final response = await _apiService.post(
      'api/login',
      {'email': email, 'password': password},
    );

    print('Response status: ${response?.statusCode}');
    print('Response body: ${response?.body}');

    if (response != null && response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody; // Devuelve el mapa de respuesta completo
    } else {
      return null;
    }
  }
}
