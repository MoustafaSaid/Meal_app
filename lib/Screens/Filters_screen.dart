import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = 'filtersScreen';
  final Function saveFilters;
  final Map<String,bool> currentFilters;

   FilterScreen({required this.saveFilters, required this.currentFilters});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool glutenFree = false;
  bool vegan = false;
  bool vegetarian = false;
  bool lactoseFree = false;
  @override
  initState(){
     glutenFree = widget.currentFilters['gluten']!;
     vegan = widget.currentFilters['vegan']!;
     vegetarian = widget.currentFilters['vegetarian']!;
     lactoseFree = widget.currentFilters['lactose']!;
    super.initState();
  }

  Widget buildSwitchTile(
      String title, String subTitle, bool currentValue, updateValue) {
    return SwitchListTile(
      value: currentValue,
      subtitle: Text(subTitle),
      onChanged: updateValue,
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
        actions: [
          IconButton(
              onPressed: () {
                Map<String, bool> filters = {
                  'gluten': glutenFree,
                  'lactose': lactoseFree,
                  'vegan': vegan,
                  'vegetarian': vegetarian,
                };
                widget.saveFilters(filters);

              },
              icon: const Icon(Icons.save_alt_outlined))
        ],
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
                      buildSwitchTile("Gluten_Free",
                          "Only Includes Gluten_Free Meals.", glutenFree, (bool value) {
                            setState(() {
                              glutenFree = value;
                            });
                          }),
                      buildSwitchTile("Lactose_Free",
                          "Only Includes Lactose_Free Meals.", lactoseFree, (bool value) {
                            setState(() {
                              lactoseFree = value;
                            });
                          }),
                      buildSwitchTile(
                          "Vegetarian", "Only Includes Vegetarian Meals.", vegetarian,
                              (bool value) {
                            setState(() {
                              vegetarian = value;
                            });
                          }),
                      buildSwitchTile(
                        "Vegan",
                        "Only Includes Vegan Meals.",
                        vegan,
                            (bool value) {
                          setState(() {
                            vegan = value;
                          });
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
