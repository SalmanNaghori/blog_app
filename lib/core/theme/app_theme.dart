import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPalette.borderColor]) => OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 3.0,
      ),
      borderRadius: BorderRadius.circular(10));

  static final darkThemeMood = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: AppPalette.backgroundColor),
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    chipTheme: const ChipThemeData(
        color: WidgetStatePropertyAll(AppPalette.backgroundColor),
        side: BorderSide.none),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: _border(AppPalette.gradient1),
      enabledBorder: _border(),
    ),
  );
}
