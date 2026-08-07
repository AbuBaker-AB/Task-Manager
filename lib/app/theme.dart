import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_radius.dart';
import '../core/constants/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),

      scaffoldBackgroundColor: AppColors.scaffold,

      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        titleTextStyle: AppTextStyles.headingMedium,
      ),

      textTheme: const TextTheme(
        displayLarge: AppTextStyles.headingLarge,
        headlineMedium: AppTextStyles.headingMedium,
        titleMedium: AppTextStyles.titleMedium,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.bodySecondary,
        bodySmall: AppTextStyles.caption,
      ),

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),

      // inputDecorationTheme: InputDecorationTheme(
      //   filled: true,
      //   fillColor: Colors.white,
      //
      //   contentPadding: const EdgeInsets.symmetric(
      //     horizontal: 16,
      //     vertical: 16,
      //   ),
      //
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(AppRadius.md),
      //     borderSide: BorderSide.none,
      //   ),
      //
      //   enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(AppRadius.md),
      //     borderSide: BorderSide.none,
      //   ),
      //
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(AppRadius.md),
      //     borderSide: const BorderSide(
      //       color: AppColors.primary,
      //       width: 1.5,
      //     ),
      //   ),
      //
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        // FIX: Replaced BorderSide.none with a visible border
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
        // FIX: Replaced BorderSide.none with a visible border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}