import 'package:flutter/material.dart';
import 'constants/colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.white),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.white),
        titleMedium: TextStyle(fontSize: 13, color: AppColors.white70, height: 1.3),
        bodySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.neonGreen, // changed from primary
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.socialButtonBg,
          foregroundColor: AppColors.white, // already correct
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          side: BorderSide(color: AppColors.socialBorder),
        ),
      ),
    );
  }
}
