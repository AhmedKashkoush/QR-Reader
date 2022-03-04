import 'dart:convert';
import 'dart:io';

import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:qr_code_reader/Utils/preferences.dart';

class AppLocales {
  static final String systemLocale = Platform.localeName.substring(0, 2);
  static Locale? language;
  static String? languageCode;
  static String languageMode = 'system';
  static Map<String, dynamic>? languageTranslation;

  static Future<void> loadLanguage() async {
    languageMode = SharedPreferencesApi.getString('Language') ?? 'system';
    switch (languageMode) {
      case 'en':
        language = Locale('en');
        break;
      case 'ar':
        language = Locale('ar');
        break;
      default:
        language = Locale(systemLocale);
        break;
    }
    await getLangJson(language!.languageCode);
    languageCode = language!.languageCode;
  }

  static Future<void> getLangJson(String languageCode) async {
    final String _jsonFile =
        await rootBundle.loadString('assets/language/$languageCode.json');
    languageTranslation = jsonDecode(_jsonFile);
  }
}
