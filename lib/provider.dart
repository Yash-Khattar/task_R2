import 'package:flutter/material.dart';

class ThemeChange extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;

  ThemeMode get getmode => _mode;

  void toggle() {
    _mode = (_mode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
