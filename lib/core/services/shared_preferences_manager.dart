import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final SharedPreferencesManager _instance = SharedPreferencesManager._internal();

  // Private constructor to prevent external instantiation
  SharedPreferencesManager._internal();

  // Getter for the singleton instance
  factory SharedPreferencesManager() {
    return _instance;
  }

  // SharedPreferences instance
  late final SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}
