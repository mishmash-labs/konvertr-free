import 'package:flutter/material.dart';

import 'themes.dart';

AppTheme appTheme = AppTheme();

/// Changes the theme of the app
class ThemeChanger with ChangeNotifier {
  /// Initializes and declare [_themeData] property with a given [ThemeData]
  /// Setter method to set the value of [_themeData]

  ThemeData _themeData = appTheme.getDarkTheme();

  /// Getter method to get the value of [_themeData]

  ThemeData get themeData => _themeData;

  set themeData(ThemeData newValue) {
    _themeData = newValue;
    // This notifies listeners
    notifyListeners();
  }
}
