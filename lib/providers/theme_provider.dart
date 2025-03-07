import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _appThemeMode = ThemeMode.light;

  // Getter for the current theme mode
  ThemeMode get appThemeMode => _appThemeMode;

  // Getter to check if the theme is dark
  bool get isDark => _appThemeMode == ThemeMode.dark;

  // Method to change the theme mode
  void changeThemeMode(ThemeMode themeMode) {
    _appThemeMode = themeMode;
    notifyListeners(); // Notify listeners about the change
  }
}
