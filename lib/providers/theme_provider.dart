import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  MaterialColor primaryColor = Colors.blueGrey;
  var accentColor = Colors.amber;
  var themeMode = ThemeMode.system;
  String themeText="s";

  onChanged(color, n) async {
    n == 1
        ? primaryColor = setMaterialColor(color.hashCode)
        : accentColor = setMaterialColor(color.hashCode);
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setInt("primaryColor", primaryColor.value);
    preferences.setInt("accentColor", accentColor.value);
    notifyListeners();

  }
  getThemeColor()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
   primaryColor= setMaterialColor(preferences.getInt("primaryColor")??0xffe91e63);
   accentColor= setMaterialColor(preferences.getInt("accentColor")??0xffffc107);
   notifyListeners();
  }

  MaterialColor setMaterialColor(colorVal) {
    return MaterialColor(colorVal,<int, Color>{
      50: const Color(0xFFFFF3E0),
      100: const Color(0xFFFFE0B2),
      200:const Color(0xFFFFCC80),
      300: const Color(0xFFFFB74D),
      400:const Color(0xFFFFA726),
      500:  Color(colorVal),
      600: const Color(0xFFFB8C00),
      700: const Color(0xFFF57C00),
      800:const Color(0xFFEF6C00),
      900: const Color(0xFFE65100),
    }, );
  }

  void themeModeChange(newThemeVal) async {
    themeMode = newThemeVal;
    getThemeText(themeMode);
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString("themeText", themeText);
    notifyListeners();
  }

  getThemeText(ThemeMode themeMode)async{
    if(themeMode==ThemeMode.dark){
      themeText="d";
    }else if(themeMode==ThemeMode.light){
      themeText="l";
    }else if (themeMode==ThemeMode.system){
      themeText="s";
    }
  }
  getThemeMode()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
   themeText= preferences.getString("themeText")??"S";
    if( themeText=="d"){
     themeMode=ThemeMode.dark;
    }else if( themeText=="l"){
     themeMode=ThemeMode.light;
    }else if ( themeText=="s"){
     themeMode=ThemeMode.system;
    }
    notifyListeners();
  }
}
