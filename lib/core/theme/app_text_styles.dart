import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppTextStyles {
  static TextStyle displayLarge = GoogleFonts.dmMono(
    fontSize: 52,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: -1.5,
  );

  static TextStyle displayMedium = GoogleFonts.dmMono(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: -1.0,
  );

  static TextStyle headingLarge = GoogleFonts.dmMono(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle headingMedium = GoogleFonts.dmMono(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle body = GoogleFonts.dmMono(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySecondary = GoogleFonts.dmMono(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle label = GoogleFonts.dmMono(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
    letterSpacing: 2.0,
  );

  static TextStyle resultDisplay = GoogleFonts.dmMono(
    fontSize: 44,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
    letterSpacing: -2.0,
  );

  static TextStyle categoryTitle = GoogleFonts.dmMono(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );
}
