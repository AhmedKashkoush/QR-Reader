import 'package:flutter/material.dart';
import 'package:qr_code_reader/Utils/AppSettings/Theme/themes.dart';

import '../../preferences.dart';

class ThemeProvider extends ChangeNotifier {
  void setTheme(ThemeMode themeMode) async {
    AppTheme.themeMode = themeMode;
    SharedPreferencesApi.setString('Theme', themeMode.name);
    notifyListeners();
  }
}
