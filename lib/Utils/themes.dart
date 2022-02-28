import 'package:flutter/material.dart';

class AppTheme {
  static ThemeMode themeMode = ThemeMode.light;
  static final ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: Colors.black,
      primarySwatch: Colors.blueGrey,
    ),
    highlightColor: Colors.transparent,
    splashFactory: InkRipple.splashFactory,
    brightness: Brightness.light,
  );
}
