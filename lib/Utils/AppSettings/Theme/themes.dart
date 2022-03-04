import 'package:flutter/material.dart';
import 'package:qr_code_reader/Utils/preferences.dart';

class AppTheme {
  static ThemeMode themeMode = ThemeMode.system;
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
    toggleableActiveColor: Colors.blueGrey,
    appBarTheme: AppBarTheme(
      color: Colors.blueGrey,
    ),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: Colors.black,
      primarySwatch: Colors.blueGrey,
      brightness: Brightness.light,
    ),
    highlightColor: Colors.transparent,
    splashFactory: InkRipple.splashFactory,
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Colors.teal.shade800,
    scaffoldBackgroundColor: Colors.grey.shade900,
    toggleableActiveColor: Colors.teal.shade800,
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.teal.shade800,
    ),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: Colors.teal,
      primarySwatch: Colors.teal,
      brightness: Brightness.dark,
      primaryColorDark: Colors.greenAccent,
    ),
    highlightColor: Colors.transparent,
    splashFactory: InkRipple.splashFactory,
    brightness: Brightness.dark,
  );

  static void loadThemeMode() {
    final String? _themeMode =
        SharedPreferencesApi.getString('Theme') ?? 'system';
    switch (_themeMode) {
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.system;
    }
  }
}
