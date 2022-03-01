import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesApi {
  static SharedPreferences? _prefs;
  static Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void setString(String key, String value) {
    _prefs!.setString(key, value);
  }

  static String? getString(String key) => _prefs!.getString(key);
}
