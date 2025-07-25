import 'package:flutter/material.dart';

class AppTheme {
  static const Color white = Color(0xffffffff);
  static const Color dark = Color(0x000000);
  static ThemeData lightTheme = ThemeData(scaffoldBackgroundColor: white,appBarTheme: AppBarTheme(
    color: white
  ));

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: dark,
    appBarTheme: AppBarTheme(
    color: dark
  ));
}
