import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String logoPath;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final VoidCallback? onLogoutPressed; // Haz que sea opcional

  CustomAppBar({
    required this.logoPath,
    required this.buttonText,
    required this.onButtonPressed,
    this.onLogoutPressed, // Opcional
  });

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
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: onButtonPressed,
                      child: Text(buttonText),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d7c0f),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  if (onLogoutPressed !=
                      null) // Solo muestra el botón si se proporciona la función
                    ElevatedButton(
                      onPressed: onLogoutPressed,
                      child: Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d7c0f),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                ],
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
