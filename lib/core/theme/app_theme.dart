import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryYellow,
      scaffoldBackgroundColor: AppColors.softCream,
      cardColor: AppColors.cardWhite,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.heading1,
        displayMedium: AppTextStyles.heading2,
        displaySmall: AppTextStyles.heading3,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.primaryOrange,
        surface: AppColors.softCream,
      ),
      useMaterial3: true,
    );
  }
}
