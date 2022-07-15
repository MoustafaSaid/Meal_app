import 'package:flutter/material.dart';
import 'package:meal_app/Screens/Filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon,Function () tapHandler) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap:tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            decoration:const BoxDecoration(
              gradient:  LinearGradient(colors: [
                Colors.teal,
                Colors.deepPurple
              ])
            ),
            child:const Text(
              'Cooking Up!',
              style:  TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color:Colors.white60
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTile('Meal', Icons.restaurant,(){
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Filter', Icons.settings,(){
            Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
          }),
        ],
      ),
    );
  }
}
