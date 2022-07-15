

import 'package:flutter/material.dart';
import 'package:meal_app/Screens/category_screen.dart';
import 'package:meal_app/Screens/favorites_screen.dart';
import 'package:meal_app/modules/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
final List<Meal> favoriteMeals;

  const TabsScreen({ required this.favoriteMeals});
  @override
  State<TabsScreen> createState() => _TabsScreenState();

}

class _TabsScreenState extends State<TabsScreen> {
  int currentIndex = 0;

  selectedScreen(int value) {
    setState(() {
      currentIndex = value;
    });
  }
  @override
  Widget build(BuildContext context) {

    List<Map<String, Object>> pages =[];
    pages= [
      {
        'page': const CategoryScreen(),
        'title': 'categories',
      }
      , {
        'page':  FavoritesScreen( favoriteMeals: widget.favoriteMeals),
        'title': 'Your Favorites'
      }
    ];
    return Scaffold(
      appBar: AppBar(title: Text(pages[currentIndex]['title'].toString())),
      body: pages[currentIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(

        onTap: selectedScreen,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        selectedItemColor:Colors.white ,
        // unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(

            icon: Icon(Icons.category),
            label: 'categories',

          ),
          BottomNavigationBarItem(

            icon: Icon(Icons.star),
            label: 'Your favorites',

          ),
        ],
      ),
      drawer:  MainDrawer(),
    );
  }


}
