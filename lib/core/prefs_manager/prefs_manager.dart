
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/content.dart';

class PrefsManager{
  static const saveLang = "en";
  static late SharedPreferences prefs;

  static void setLanguage(String language){
    prefs.setString(CacheConstant.languageKey, language);
  }
  static String? getLanguage(){
    return prefs.getString(CacheConstant.languageKey);
  }

  static Future<void> init()async {
    prefs = await SharedPreferences.getInstance();
  }

  static void saveTheme(ThemeMode theme){
    if(theme == ThemeMode.dark){
      prefs.setString(CacheConstant.ThemeKey, "dark");
    }else{
      prefs.setString(CacheConstant.ThemeKey, "light");
    }
  }

  static ThemeMode? getTheme(){
    String? theme = prefs.getString(CacheConstant.ThemeKey);
    if(theme == null){
      return null;
    }else{
      if(theme == "light"){
        return ThemeMode.light;
      }else{
        return ThemeMode.dark;
      }
    }
  }
}