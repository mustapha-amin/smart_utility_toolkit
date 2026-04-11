import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color black = Color(0xFF000000);
  static const Color surface = Color(0xFF0F0F0F);
  static const Color elevated = Color(0xFF1C1C1C);
  static const Color highlight = Color(0xFF2A2A2A);
  static const Color gradientEnd = Color(0xFF0A0A0A);
  static const Color gradientLightStart = Color(0xFF2D2D2D);
  static const Color border = Color(0xFF2A2A2A);
  static const Color borderFocused = Color(0xFFFFFFFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8A8A8A);
  static const Color textMuted = Color(0xFF4A4A4A);
  static const Color inputFill = Color(0xFF0A0A0A);

  static LinearGradient get cardGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientLightStart, gradientEnd],
  );

  static LinearGradient get resultGradient => const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [highlight, surface],
  );

  static LinearGradient get activeGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [white, Color(0xFFE0E0E0)],
  );
}
