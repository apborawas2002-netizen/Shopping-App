import 'package:flutter/material.dart';

const marketCream = Color(0xFFF4EFE6);
const marketPaper = Color(0xFFFFFCF8);
const marketInk = Color(0xFF1C1917);
const marketGreen = Color(0xFF1F4D3A);
const marketMuted = Color(0xFF6B6560);

ThemeData buildMarketTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: marketGreen,
    brightness: Brightness.light,
    primary: marketGreen,
    onPrimary: Colors.white,
    surface: marketPaper,
    onSurface: marketInk,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: marketCream,
    appBarTheme: const AppBarTheme(
      backgroundColor: marketCream,
      foregroundColor: marketInk,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: marketInk,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
      ),
    ),
    cardTheme: CardThemeData(
      color: marketPaper,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE6DFD4)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: marketGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: marketGreen,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w700,
        color: marketInk,
        letterSpacing: -0.4,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w700,
        color: marketInk,
        letterSpacing: -0.3,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        color: marketInk,
      ),
      bodyMedium: TextStyle(color: Color(0xFF4A453F), height: 1.35),
    ),
  );
}
