import 'package:flutter/material.dart';

import '../cache/cache_helper.dart';

class LanguageProvider extends ChangeNotifier{
  String appLanguage = "en";

  LanguageProvider(){
    loadLanguageFromCache();
  }

  loadLanguageFromCache(){
    var cachedLanguage = CacheHelper.getData(key: "language_selected");
    appLanguage = cachedLanguage == "ar" ? appLanguage = "ar" : appLanguage = "en" ;
    notifyListeners();
  }

  void changeLanguage(String newLanguage){
    if(appLanguage == newLanguage){
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }
}