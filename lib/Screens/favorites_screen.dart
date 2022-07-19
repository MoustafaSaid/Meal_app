import 'package:flutter/material.dart';
import 'package:meal_app/modules/meals.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    var deviceWidth=MediaQuery.of(context).size.width;
    final List<Meal> favoriteMeals =
        Provider.of<MealProvider>(context, listen: true).favoriteMeals;

    if (favoriteMeals.isEmpty) {
      return const Center(
        child: Text("You Have No Favorites Yet - Start dding Some!"),
      );
    } else {
      return GridView.builder(
        gridDelegate:   SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: deviceWidth<=400? 400:500,
            childAspectRatio:isLandscape? deviceWidth / (deviceWidth*0.80):deviceWidth/(deviceWidth*0.75),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0
        ),
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
  }
}
