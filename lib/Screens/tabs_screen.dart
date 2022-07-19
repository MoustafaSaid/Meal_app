

import 'package:flutter/material.dart';
import 'package:meal_app/Screens/category_screen.dart';
import 'package:meal_app/Screens/favorites_screen.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);


  @override
  State<TabsScreen> createState() => _TabsScreenState();

}

class _TabsScreenState extends State<TabsScreen> {
  int currentIndex = 0;
  late List<Map<String, Object>> pages;

  @override
  void initState(){
    Provider.of<MealProvider>(context,listen: false).setData();
    Provider.of<ThemeProvider>(context,listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context,listen: false).getThemeColor();
  pages= [
    {
      'page': const CategoryScreen(),
      'title': 'categories',
    }
    , {
      'page': const FavoritesScreen(),
      'title': 'Your Favorites'
    }
  ];
  super.initState();
}
  selectedScreen(int value) {

    setState(() {
      currentIndex = value;
    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text(pages[currentIndex]['title'].toString())),
      body: pages[currentIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(

        onTap: selectedScreen,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        selectedItemColor:Colors.white ,
        unselectedItemColor: Colors.black54,
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
