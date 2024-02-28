import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AppThemeKeys { light, dark }

class FontSize {
  static const int big = 18;
  static const int medium = 14;
  static const int small = 10;
}

Map<AppThemeKeys, ThemeData> _themes = {
  AppThemeKeys.light: ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Colors.pink),
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
          primary: Colors.pink, secondary: Colors.white),
      fontFamily: 'Lexend'),
  AppThemeKeys.dark: ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Colors.blueGrey),
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
          primary: Colors.black, secondary: Colors.blueGrey),
      fontFamily: 'Roboto')
};

class AppTheme extends ChangeNotifier {
  static AppTheme of(BuildContext context, {bool listen = false}) =>
      Provider.of<AppTheme>(context, listen: listen);

  AppThemeKeys _themeKey = AppThemeKeys.light;
  ThemeData? get currentTheme => _themes[_themeKey];
  AppThemeKeys get currentThemeKey => _themeKey;

  void setTheme(AppThemeKeys themeKey) {
    _themeKey = themeKey;

    notifyListeners();
  }

  void switchTheme() {
    if (_themeKey == AppThemeKeys.dark) {
      _themeKey = AppThemeKeys.light;
    } else {
      _themeKey = AppThemeKeys.dark;
    }

    notifyListeners();
  }
}
