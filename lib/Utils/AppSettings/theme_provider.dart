import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_reader/Utils/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../preferences.dart';

class ChangeTheme extends ChangeNotifier {

  void setTheme(ThemeMode themeMode) async{
    AppTheme.themeMode = themeMode;
    SharedPreferencesApi.setString('Theme', themeMode.name);
    notifyListeners();
  }
}
