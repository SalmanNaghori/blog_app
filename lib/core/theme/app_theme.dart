import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(10)
      );

  static final darkThemeMood = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.backgroundColor
    ),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: _border(AppPallete.gradient1),
      enabledBorder: _border(),
    ),
  );
}
