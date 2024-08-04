import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http; // Asegúrate de agregar esta dependencia

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String logoPath;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final String? logoutUrl; // Hacemos que la URL de logout sea opcional
  final VoidCallback?
      onLogoutSuccess; // Función opcional para navegación después de logout

  CustomAppBar({
    required this.logoPath,
    required this.buttonText,
    required this.onButtonPressed,
    this.logoutUrl,
    this.onLogoutSuccess,
  });

  Future<void> _handleLogout() async {
    if (logoutUrl != null) {
      // Realiza la solicitud POST para logout
      final response = await http.post(Uri.parse(logoutUrl!));

      if (response.statusCode == 200) {
        // Logout exitoso, realiza las acciones necesarias (como navegación)
        print('Logout exitoso');
        if (onLogoutSuccess != null) {
          onLogoutSuccess!(); // Llama a la función de navegación después del logout
        }
      } else {
        // Maneja el error de logout
        print('Error en el logout');
      }
    } else {
      // Si no se proporciona logoutUrl, simplemente ejecuta la función callback
      onButtonPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFEBF8E4),
        toolbarHeight: 85,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(
              top: 20, left: 10, right: 10), // Padding superior aquí
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  logoPath,
                  width: 75,
                  height: 75,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  onPressed: _handleLogout,
                  child: Text(buttonText),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4d7c0f), // Fondo del botón
                    foregroundColor: Colors.white, // Color del texto del botón
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Bordes redondeados
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(85.0); // Altura del AppBar
}
