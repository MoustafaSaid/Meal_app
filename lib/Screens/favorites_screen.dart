import 'package:flutter/material.dart';
import 'package:meal_app/modules/meals.dart';

import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  const FavoritesScreen({required this.favoriteMeals}) ;

  @override
  Widget build(BuildContext context) {
    if(favoriteMeals.isEmpty){
    return const Center(
      child: Text("You Have No Favorites Yet - Start dding Some!"),
    );
  }else{
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            imageUrl: favoriteMeals[index].imageUrl,
            title: favoriteMeals[index].title,
            affordability: favoriteMeals[index].affordability,
            complexity: favoriteMeals[index].complexity,
            duration: favoriteMeals[index].duration,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
}}
