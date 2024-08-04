import 'package:flutter/material.dart';
import 'dart:convert'; // Importa el paquete para trabajar con JSON
import '../api/auth_service.dart';
import '../api/api_service.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final AuthService _authService = AuthService(
      ApiService('http://10.0.2.2:3000')); // Reemplaza con tu URL de API

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final response = await _authService.login(_email, _password);
      if (response != null) {
        print('Login response: $response');
        Navigator.pushNamedAndRemoveUntil(
            context, 'dashboard', (route) => false);
      } else {
        print('Error al iniciar sesión');
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu email';
    }
    // Validación básica de email usando una expresión regular
    const emailPattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    final regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Por favor, ingresa un email válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF98CF56),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: 400,
          height: 413,
          child: Container(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildInputField(
                    labelText: 'Email',
                    focusNode: _emailFocusNode,
                    validator: _validateEmail,
                    onSaved: (value) {
                      _email = value ?? '';
                    },
                  ),
                  SizedBox(height: 20),
                  _buildInputField(
                    labelText: 'Password',
                    obscureText: true,
                    focusNode: _passwordFocusNode,
                    validator: _validatePassword,
                    onSaved: (value) {
                      _password = value ?? '';
                    },
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4D7C0F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      minimumSize: Size(352, 50),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String labelText,
    bool obscureText = false,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    required FocusNode focusNode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: labelText,
            fillColor: Colors.transparent, // Fondo transparente
            filled: true,
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: focusNode.hasFocus
                    ? Colors.white
                    : Colors.white.withOpacity(
                        0.5), // Línea blanca o semi-transparente según el estado de enfoque
                width: 2.0, // Grosor de la línea
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white, // Línea blanca cuando está enfocado
                width: 2.0, // Grosor de la línea
              ),
            ),
            errorStyle: TextStyle(
              color: Colors.red, // Color rojo para el texto del error
              fontWeight:
                  FontWeight.bold, // Fuente en negrita para el mensaje de error
            ),
            labelStyle: TextStyle(
              color: focusNode.hasFocus
                  ? Colors.white
                  : Colors.white.withOpacity(
                      0.5), // Color del texto del placeholder y label
              fontWeight:
                  FontWeight.bold, // Fuente en negrita para el texto del label
            ),
          ),
          style: TextStyle(
            color: Colors.white, // Color del texto del campo
            fontWeight:
                FontWeight.bold, // Fuente en negrita para el texto del campo
          ),
          obscureText: obscureText,
          validator: validator,
          onSaved: onSaved,
        ),
      ],
    );
  }
}
