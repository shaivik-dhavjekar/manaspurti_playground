import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  late SharedPreferences _prefs;

  ThemeProvider() {
    _initPrefs();
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final themeString = _prefs.getString('theme');
    if (themeString != null) {
      _themeMode = ThemeMode.values[int.parse(themeString)];
    }
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _prefs = await SharedPreferences.getInstance();
    _themeMode = mode;
    _prefs.setString('theme', mode.index.toString());
    notifyListeners();
  }

  String getAppTheme() {
    switch(themeMode) {
      case ThemeMode.light: return 'Light';
      case ThemeMode.dark: return 'Dark';
      case ThemeMode.system: return 'System';
    }
  }
}