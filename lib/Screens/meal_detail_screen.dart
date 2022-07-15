import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'Meal_Details';
  final Function toggleFavorites;
  final Function isMealFavorites;


  const MealDetailScreen({required this.toggleFavorites, required this.isMealFavorites});

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Colors.black12,
            Colors.white10,
          ]),
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 150,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.teal, Colors.deepPurple]),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildSectionTitle(context, "Ingredients"),
              buildContainer(ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.teal[400],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        selectedMeal.ingredients[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              )),
              buildSectionTitle(context, "Steps"),
              buildContainer(ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# $index'),
                          radius: 18,
                        ),
                        title: Text(
                          selectedMeal.steps[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Divider(thickness: 4),
                    ],
                  );
                },
                itemCount: selectedMeal.steps.length,
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:()=>toggleFavorites(mealId),
        child: Icon(
          isMealFavorites(mealId)? Icons.star:Icons.star_border
        ),
      ),
    );
  }
}
