import 'package:flutter/material.dart';
import 'package:meal_app/Screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(
      {Key? key, required this.id, required this.title, required this.color})
      : super(key: key);

  void selectedCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      CategoryMealsScreen.routeName,
    arguments: {
        'id':id,
      'title':title
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectedCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            color: color,
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
