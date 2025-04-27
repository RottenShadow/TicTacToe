import 'package:flutter/material.dart';
import 'package:xo/theme/app_colors.dart';

class AppTheme {
  static ThemeData getThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: "Juvanze",
      primaryColor: AppColors.kGradient1,
      scaffoldBackgroundColor: AppColors.kGradient1,
      appBarTheme: _getAppBarTheme(),
    );
  }

  static AppBarTheme _getAppBarTheme() {
    return const AppBarTheme(
      backgroundColor: AppColors.kGradient1,
      foregroundColor: AppColors.kWhitish,
      titleTextStyle: TextStyle(fontFamily: "PermanentMarker", fontSize: 24),
    );
  }
}
