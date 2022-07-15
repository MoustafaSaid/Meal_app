import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_app/Screens/Filters_screen.dart';
import 'package:meal_app/Screens/category_meals_screen.dart';
import 'package:meal_app/Screens/meal_detail_screen.dart';
import 'package:meal_app/Screens/tabs_screen.dart';

import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/modules/meals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Map<String,bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void setFilters(Map<String, bool> filtersData) {
    setState(() {
      filters = filtersData;
      availableMeals = DUMMY_MEALS.where((meal) {
        if (filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }
  void toggleFavorites(String mealId){
    final existingIndex=favoriteMeals.indexWhere((meal) => meal.id==mealId);
    if(existingIndex>=0){
      setState((){
        favoriteMeals.removeAt(existingIndex);
      });
    }else {
      setState((){
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
      });
    }
  }
  bool isMealFavorites(String mealId){
    return favoriteMeals.any((meal) => meal.id==mealId);
  }

  @override
  Widget build(BuildContext context) {
    var color=const Color(0xffA26769);
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor:color,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          ),
          // titleTextStyle: TextStyle(
          //   // color: Colors.white
          // )
        ),
          primarySwatch:Colors.cyan ,
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                headlineLarge: const TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                headlineSmall:
                    const TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
                titleMedium: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
      routes: {
        '/': (context) =>  TabsScreen(favoriteMeals:favoriteMeals),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(
              availableMeals: availableMeals,
            ),
        MealDetailScreen.routeName: (context) => MealDetailScreen(toggleFavorites: toggleFavorites,isMealFavorites: isMealFavorites),
        FilterScreen.routeName: (context) => FilterScreen(saveFilters: setFilters, currentFilters: filters),
      },
      // home: Scaffold(
      //   body: null,
      // ) ,
    );
  }
}
