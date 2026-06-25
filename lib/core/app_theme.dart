import 'package:flutter/material.dart';

class AppTheme {
  static const primaryLight = Color(0xFF6EC6FF);
  static const primarySerenity = Color(0xFF6EC6FF);
  static const primarySoft = Color(0xFFF5F7FA);
  static const secondaryMint = Color(0xFF4DD0E1);
  static const secondaryAqua = Color(0xFF4DD0E1);
  static const backgroundLight = Color(0xFFF5F7FA);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceVariantLight = Color(0xFFDEE2E6);
  static const textDark = Color(0xFF343A40);
  static const success = Color(0xFF52B788);
  static const warning = Color(0xFFFFD166);
  static const error = Color(0xFFEF476F);

  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primarySerenity,
      onPrimary: textDark,
      secondary: secondaryMint,
      onSecondary: textDark,
      surface: surfaceLight,
      onSurface: textDark,
      error: error,
      onError: surfaceLight,
      primaryContainer: primaryLight,
      onPrimaryContainer: textDark,
      secondaryContainer: secondaryAqua,
      onSecondaryContainer: textDark,
      surfaceTint: primarySerenity,
    ),
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: primarySoft,
      foregroundColor: textDark,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: surfaceLight,
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primarySerenity,
        foregroundColor: textDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: textDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: const BorderSide(color: textDark12),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge:
          TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: textDark),
      titleLarge:
          TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: textDark),
      titleMedium:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textDark),
      bodyLarge: TextStyle(fontSize: 16, color: textDark),
      bodyMedium: TextStyle(fontSize: 14, color: textDark),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: primarySoft,
      onPrimary: Colors.black,
      secondary: secondaryAqua,
      onSecondary: Colors.black,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
      error: error,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF1E1E1E),
      elevation: 2,
      shadowColor: Colors.black38,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primarySoft,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );
}

const Color textDark12 = Color(0xFF343A40);
