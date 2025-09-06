import 'package:flutter/material.dart';
import 'colors.dart'; // your colors.dart

class AppTheme {
  static const _labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.buttonForeground,
    inherit: true,
  );
  static const _labelLargeDark = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    inherit: true,
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    primaryColor: AppColors.primaryBlue,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryWhite,
      iconTheme: IconThemeData(color: AppColors.iconColor),
      titleTextStyle: TextStyle(color: AppColors.textColor, fontSize: 20),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(color: AppColors.textColor),
      bodyLarge: TextStyle(color: AppColors.bodyText),
      bodyMedium: TextStyle(color: AppColors.textColor),
      labelLarge: _labelLarge,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonBackground,
        foregroundColor: AppColors.buttonForeground,
        textStyle: _labelLarge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    ),
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColors.primaryBlue,
      secondary: AppColors.lightBlue,
      surface: AppColors.primaryWhite,
      onPrimary: AppColors.buttonForeground,
      onSecondary: AppColors.textColor,
      onSurface: AppColors.textColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: const Color(0xFF7C4DFF), // Purple
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF7C4DFF),
      secondary: Color(0xFF4CAF50), // Green (for "Easy")
      error: Color(0xFFF44336),
      surface: Color(0xFF2C2C2C),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
      onSurface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Color(0xFFCCCCCC)),
      bodyMedium: TextStyle(color: Color(0xFFCCCCCC)),
      labelLarge: _labelLargeDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF7C4DFF),
        foregroundColor: Colors.white,
        textStyle: _labelLargeDark,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: Colors.purpleAccent,
      inactiveTrackColor: Colors.grey,
      thumbColor: Colors.purple,
    ),
  );
}
