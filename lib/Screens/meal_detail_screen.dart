import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'Meal_Details';

  Widget buildSectionTitle(BuildContext context, String title) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildContainer(Widget child,BuildContext context) {
    bool isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    var deviceWidth=MediaQuery.of(context).size.width;
    var deviceHeight=MediaQuery.of(context).size.height;
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
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        height: isLandscape?deviceHeight*0.5:deviceHeight*0.25,
        width: isLandscape? (deviceWidth*0.5-30):deviceWidth,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    var ing=ListView.builder(
      padding: EdgeInsets.all(0),
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
    );
    var steps=ListView.builder(
      padding: EdgeInsets.all(0),

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
    );
    bool isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;

    return Scaffold(

      body: CustomScrollView(
        slivers: [
          SliverAppBar(

            expandedHeight: 300,
            pinned: true,

            flexibleSpace: FlexibleSpaceBar(
                title: Text(selectedMeal.title),

                background: Hero(
                tag: mealId,
                child: InteractiveViewer(

                  child: Image.network(
                    selectedMeal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),


          ),
          SliverList(delegate: SliverChildListDelegate([
            if(isLandscape)
              Row(
                children: [

                  Column(children: [
                    buildSectionTitle(context, "Ingredients"),
                    buildContainer(ing,context),
                  ],),
                  Column(children: [
                    buildSectionTitle(context, "Steps"),
                    buildContainer(steps,context)
                  ],)
                ],
              ),
            if(!isLandscape)
              buildSectionTitle(context, "Ingredients"),
            if(!isLandscape)
              buildContainer(ing,context),
            if(!isLandscape)
              buildSectionTitle(context, "Steps"),
            if(!isLandscape)
              buildContainer(steps,context)
          ]))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .toggleFavorites(mealId),
        child: Icon(Provider.of<MealProvider>(context, listen: true)
                .isFavorite(mealId)
            ? Icons.star
            : Icons.star_border),
      ),
    );
  }
}
