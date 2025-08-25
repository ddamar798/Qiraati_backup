import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF6BBE92); // hijau soft
  static const Color accentGreen = Color(0xFF4A9D79);
  static const Color bgLight = Color(0xFFF5F8F6);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: bgLight,
    fontFamily: "LpmqisepMisbah",
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
  );
}