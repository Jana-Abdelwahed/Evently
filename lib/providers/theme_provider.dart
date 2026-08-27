import 'package:evently/cache/cache_helper.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode appTheme = ThemeMode.light;

  ThemeProvider(){
    loadThemeFromCache();
  }

  loadThemeFromCache(){
    var cachedTheme = CacheHelper.getData(key: "theme_selected");
    appTheme = cachedTheme == "dark" ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme){
    if(appTheme == newTheme){
      return;
    }
    appTheme = newTheme;
    notifyListeners();
  }

  bool get isDark => appTheme == ThemeMode.dark;
}