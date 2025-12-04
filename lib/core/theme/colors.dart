import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryYellow = Color(0xFFF9D976);
  static const Color primaryOrange = Color(0xFFF5B041);
  static const Color softCream = Color(0xFFFFF7E8);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color greyText = Color(0xFF6E6E6E);
  static const Color darkText = Color(0xFF1A1A1A);
  static const Color accentBlue = Color(0xFF5B8DEF);
  static const Color accentGreen = Color(0xFF58D68D);
  static const Color accentPurple = Color(0xFFA569BD);
  
  // Gradients
  static const LinearGradient creamGradient = LinearGradient(
    colors: [Color(0xFFFFF7D6), Color(0xFFFEECC8), Color(0xFFFDF7E1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryYellow, primaryOrange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
