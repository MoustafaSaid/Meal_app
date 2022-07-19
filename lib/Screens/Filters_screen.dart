import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = 'filtersScreen';

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {


  Widget buildSwitchTile(
      String title, String subTitle, bool currentValue, updateValue) {
    return SwitchListTile(
      inactiveTrackColor: Provider.of<ThemeProvider>(context,listen: true).themeMode==ThemeMode.light?null:Colors.black,
      value: currentValue,
      subtitle: Text(subTitle,style:const TextStyle(fontSize: 16)),
      onChanged: updateValue,
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final Function  saveFilters=  Provider.of<MealProvider>(context, listen: true).setFilters(filtersData);
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Adjust Your Meal Selection",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
                child: Container(
              child: ListView(
                children: [
                  buildSwitchTile(
                      "Gluten_Free",
                      "Only Includes Gluten_Free Meals.",
                      currentFilters['gluten']!, (bool value) {
                    setState(() {
                      currentFilters['gluten'] = value;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  }),
                  buildSwitchTile(
                      "Lactose_Free",
                      "Only Includes Lactose_Free Meals.",
                      currentFilters['lactose']!, (bool value) {
                    setState(() {
                      currentFilters['lactose'] = value;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  }),
                  buildSwitchTile(
                      "Vegetarian",
                      "Only Includes Vegetarian Meals.",
                      currentFilters['vegetarian']!, (bool value) {
                    setState(() {
                      currentFilters['vegetarian'] = value;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  }),
                  buildSwitchTile(
                    "Vegan",
                    "Only Includes Vegan Meals.",
                    currentFilters['vegan'] !,
                    (bool value) {
                      setState(() {
                        currentFilters['vegan'] = value;
                      });
                      Provider.of<MealProvider>(context, listen: false)
                          .setFilters();
                    },
                  )
                ],
              ),
            ))
          ],
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
