import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkTheme = false;

  SharedPreferences _prefs;

  bool get theme => _darkTheme;

  ThemeProvider() {
    _loadPrefs();
  }

  setDarkTheme(theme) {
    _darkTheme = theme;
    _savePrefs();
    notifyListeners();
  }

  initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  _savePrefs() async {
    await initPrefs();
    _prefs.setBool('theme', _darkTheme);
  }

  _loadPrefs() async {
    await initPrefs();
    _darkTheme = _prefs.getBool('theme') ?? false;
    notifyListeners();
  }
}
