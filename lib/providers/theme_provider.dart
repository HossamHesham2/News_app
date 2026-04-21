

import 'package:flutter/material.dart';
import 'package:news_app/core/prefs_manager/prefs_manager.dart';

class ThemeProvider extends ChangeNotifier {
   ThemeMode currentTheme = PrefsManager.getTheme() ?? ThemeMode.dark;


  void ChangeAppTheme(ThemeMode newTheme){
    if(currentTheme == newTheme) return;
    currentTheme = newTheme;
    PrefsManager.saveTheme(currentTheme);
    notifyListeners();
  }

  bool get isDark => currentTheme == ThemeMode.dark;
}