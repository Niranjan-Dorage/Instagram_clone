import 'package:flutter/material.dart';

class Themechanger with ChangeNotifier {
  var _thememode = ThemeMode.system;
  ThemeMode get thememode => _thememode;
  void setTheme(thememode) {
    _thememode = thememode;
    notifyListeners();
  }
}
