import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(25),

        gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20
        ),
        children:
        Provider.of<MealProvider>(context).availableCategory.map((catData) =>
            CategoryItem(id: catData.id, title: catData.title, color: catData.color)
        ).toList(),

      ),
    );
  }
}
