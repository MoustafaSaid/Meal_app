
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_app/Screens/Filters_screen.dart';
import 'package:meal_app/Screens/category_meals_screen.dart';
import 'package:meal_app/Screens/meal_detail_screen.dart';
import 'package:meal_app/Screens/tabs_screen.dart';
import 'package:meal_app/Screens/theme_screen.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers:[
    ChangeNotifierProvider<MealProvider>(
    create: (context) => MealProvider(),),
      ChangeNotifierProvider<ThemeProvider>(
        create: (context)=>ThemeProvider(),
      ),

    ],
  child: const MyApp(),
    ),);

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var color = const Color(0xffA26769);
    // var color1 = const Color(0xff272838);
    MaterialColor primaryColor=Provider.of<ThemeProvider>(context,listen: true).primaryColor;
    var accentColor=Provider.of<ThemeProvider>(context,listen: true).accentColor;
    // final ThemeData themeData=ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
backgroundColor: primaryColor,
          primarySwatch: primaryColor,
          cardColor: primaryColor,

          shadowColor: Colors.white60,
          unselectedWidgetColor: Colors.white70,
          brightness: Brightness.dark,
          buttonTheme: ButtonThemeData(colorScheme: ColorScheme.dark().copyWith(background: Colors.white70)),
          iconTheme:const IconThemeData(color: Colors.white70),
          textTheme: ThemeData.dark().textTheme.copyWith(
            headlineLarge: const TextStyle(color: Colors.white70),
            headlineSmall: const TextStyle(color: Colors.white70),
            titleMedium: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),
          )),
      theme:  ThemeData(
          primarySwatch: primaryColor,
          backgroundColor: primaryColor,
          cardColor: primaryColor,

          colorScheme:  ColorScheme.fromSeed(seedColor: accentColor,primary: accentColor),

          brightness: Brightness.light,
          iconTheme:const IconThemeData(color: Colors.black54),
          textTheme: ThemeData.light().textTheme.copyWith(
            headlineLarge: const TextStyle(color: Colors.black54),
            headlineSmall: const TextStyle(color: Colors.black54),
            titleMedium: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),
          )),
      themeMode: Provider.of<ThemeProvider>(context,listen: true).themeMode,
      routes: {
        '/': (context) => const TabsScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FilterScreen.routeName: (context) => FilterScreen(),
        ThemeScreen.routeName:(context)=>const ThemeScreen(),
      },
      // home: Scaffold(
      //   body: null,
      // ) ,
    );
  }
}