import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/modules/category.dart';
import 'package:meal_app/modules/meals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Category> availableCategory = DUMMY_CATEGORIES;
  // List<Category> availableCategory = DUMMY_CATEGORIES;

  List<Meal> favoriteMeals = [];
  List<String> prefsMealId = [];

  void setFilters() async {
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

List<Category> ac=[];
    for (var meal in availableMeals) {
      for (var categoryID in meal.categories) {
        for (var category in DUMMY_CATEGORIES) {
          if(category.id == categoryID){
            if(!ac.any((category) => category.id==categoryID)) {
              ac.add(category);
            }
          }
        }
      }
    }
availableCategory=ac;

    notifyListeners();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("gluten", filters["gluten"]!);
    preferences.setBool("lactose", filters["lactose"]!);
    preferences.setBool("vegan", filters["vegan"]!);
    preferences.setBool("vegetarian", filters["vegetarian"]!);
  }


  void setData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    filters["gluten"] = preferences.getBool("gluten") ?? false;
    filters["lactose"] = preferences.getBool("lactose") ?? false;
    filters["vegan"] = preferences.getBool("vegan") ?? false;
    filters["vegetarian"] = preferences.getBool("vegetarian") ?? false;
    prefsMealId = preferences.getStringList("prefsMealId") ?? [];
    for (var mealId in prefsMealId) {
      final existingIndex = favoriteMeals.indexWhere((meal) =>
      meal.id == mealId);
      if (existingIndex < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }

    notifyListeners();
  }

  void toggleFavorites(String mealId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }

    preferences.setStringList("prefsMealId", prefsMealId);

    notifyListeners();
  }

  bool isFavorite(String mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }


}
