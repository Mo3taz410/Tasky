import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_keys.dart';

import '../services/shared_preferences_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  void init() {
    final bool isDarkMode =
        SharedPreferencesManager().getBool('dark_theme') ?? true;
    themeNotifier.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> toggleTheme() async {
    // if (themeNotifier.value == ThemeMode.dark) {
    //   themeNotifier.value = ThemeMode.light;
    //   await SharedPreferencesManager().setBool('dark_theme', false);
    // } else {
    //   themeNotifier.value = ThemeMode.dark;
    //   await SharedPreferencesManager().setBool('dark_theme', true);
    // }
    final bool isDarkMode = themeNotifier.value == ThemeMode.dark;
    themeNotifier.value = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await SharedPreferencesManager().setBool(
      StorageKeys.darkTheme,
      !isDarkMode,
    );
  }

  static bool isDarkMode() => themeNotifier.value == ThemeMode.dark;
}
