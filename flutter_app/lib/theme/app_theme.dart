import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color canvasBackground = Color(0xFF0D0D11);
  static const Color glassBackground = Color(0xBF1C1C2A); // 75% opacity
  static const Color glassActive = Color(0x2EFF6B00); // 18% primary
  static const Color glassBorder = Color(0x1FFFFFFF); // 12% white
  static const Color glassActiveBorder = Color(0x73FF6B00); // 45% primary
  static const Color primaryContainer = Color(0xFFFF6B00); // Glowing Ember Orange
  static const Color primaryLight = Color(0xFFFFB693);
  static const Color onPrimary = Color(0xFF561F00);
  static const Color surface = Color(0xFF131317);
  static const Color surfaceContainer = Color(0xFF1F1F23);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB5B3C6);
  static const Color outline = Color(0xFF5A4136);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.canvasBackground,
      colorScheme: const ColorScheme.dark(
        background: AppColors.canvasBackground,
        surface: AppColors.surface,
        primary: AppColors.primaryContainer,
        secondary: AppColors.primaryLight,
        onBackground: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
        displayMedium: GoogleFonts.montserrat(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleLarge: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleMedium: GoogleFonts.montserrat(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        bodySmall: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        labelLarge: GoogleFonts.montserrat(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  static BoxDecoration ambientBackgroundDecoration = const BoxDecoration(
    color: AppColors.canvasBackground,
    gradient: RadialGradient(
      center: Alignment(-0.8, -0.8),
      radius: 1.2,
      colors: [
        Color(0x14FF6B00), // 8% amber glow
        Colors.transparent,
      ],
      stops: [0.0, 0.6],
    ),
  );
}
