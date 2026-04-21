

import 'package:flutter/foundation.dart';

import '../core/prefs_manager/prefs_manager.dart';

class LanguageProvider extends ChangeNotifier{
  String currentLang = PrefsManager.getLanguage() ?? "en";

  bool get isEnglish => currentLang == "en";

  void ChangeAppLanguage(String newLang){
    if(currentLang == newLang) return;
    currentLang = newLang;
    PrefsManager.setLanguage(currentLang);
    notifyListeners();
  }
}