import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/modules/meals.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category_meals';



  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> categoryMeals;

  @override
  didChangeDependencies() {
    final List<Meal> availableMeals= Provider.of<MealProvider>(context, listen: false).availableMeals;

    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title']!;
    categoryMeals = availableMeals.where((element) {
      return element.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void removeMeal(String mealId) {
    setState(() {
      categoryMeals.removeWhere((meal) => mealId == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
bool isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
var deviceWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: GridView.builder(
        gridDelegate:   SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: deviceWidth<=400? 400:500,
            childAspectRatio:isLandscape? deviceWidth / (deviceWidth*0.80):deviceWidth/(deviceWidth*0.75),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0
        ),

        itemBuilder: (context, index) {
          return MealItem(
            id: categoryMeals[index].id,
            imageUrl: categoryMeals[index].imageUrl,
            title: categoryMeals[index].title,
            affordability: categoryMeals[index].affordability,
            complexity: categoryMeals[index].complexity,
            duration: categoryMeals[index].duration,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
