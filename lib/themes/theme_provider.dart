import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  

  ThemeData get themeData => _themeData;

  bool get isdarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData){
    _themeData = themeData;  
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }
}
