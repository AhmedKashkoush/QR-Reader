import 'package:flutter/cupertino.dart';
import 'package:qr_code_reader/Utils/AppSettings/Language/locales.dart';

import '../../preferences.dart';

class LocaleProvider extends ChangeNotifier {
  void setLanguage(String languageCode, String languageMode) async {
    SharedPreferencesApi.setString('Language', languageMode);
    await AppLocales.getLangJson(languageCode);
    AppLocales.language = Locale(languageCode);
    AppLocales.languageMode = languageMode;
    notifyListeners();
  }
}
