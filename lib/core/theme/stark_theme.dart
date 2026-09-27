import 'package:flutter/material.dart';

class StarkColors {
  static const Color background = Color(0xFF080B10);
  static const Color surface = Color(0xFF0E141E);
  static const Color surfaceElevated = Color(0xFF151F2E);
  static const Color border = Color(0xFF1E2D42);
  
  // Tactical HUD Accents
  static const Color cyan = Color(0xFF00E5FF);
  static const Color amber = Color(0xFFFFB300);
  static const Color emerald = Color(0xFF00E676);
  static const Color crimson = Color(0xFFFF1744);
  static const Color purple = Color(0xFF7C4DFF);
  
  // Typography
  static const Color textPrimary = Color(0xFFF0F4F8);
  static const Color textSecondary = Color(0xFF90A4AE);
  static const Color textMuted = Color(0xFF546E7A);
}

class StarkTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: StarkColors.background,
      primaryColor: StarkColors.cyan,
      cardColor: StarkColors.surface,
      dividerColor: StarkColors.border,
      colorScheme: const ColorScheme.dark(
        primary: StarkColors.cyan,
        secondary: StarkColors.amber,
        surface: StarkColors.surface,
        error: StarkColors.crimson,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: StarkColors.textPrimary,
          fontSize: 26,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
        headlineMedium: TextStyle(
          color: StarkColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
        titleMedium: TextStyle(
          color: StarkColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: StarkColors.textSecondary,
          fontSize: 14,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          color: StarkColors.textMuted,
          fontSize: 12,
        ),
      ),
    );
  }
}
