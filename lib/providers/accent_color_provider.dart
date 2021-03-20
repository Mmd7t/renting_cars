import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccentColorProvider extends ChangeNotifier {
  int _color = 0;

  SharedPreferences _prefs;

  int get color => _color;

  AccentColorProvider() {
    _loadPrefs();
  }

  setColor(color) {
    _color = color;
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
    _prefs.setInt('accentColor', _color);
  }

  _loadPrefs() async {
    await initPrefs();
    _color = _prefs.getInt('accentColor') ?? 0;
    notifyListeners();
  }
}
