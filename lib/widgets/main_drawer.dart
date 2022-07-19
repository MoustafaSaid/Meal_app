import 'package:flutter/material.dart';
import 'package:meal_app/Screens/Filters_screen.dart';
import 'package:meal_app/Screens/theme_screen.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon,Function () tapHandler,BuildContext context) {
    return ListTile(
      leading: Icon(icon,color: Theme.of(context).iconTheme.color,),
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
      elevation: 0,
      backgroundColor:Provider.of<ThemeProvider>(context).primaryColor ,
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).accentColor,

              //   gradient:  LinearGradient(colors: [
              //   Colors.teal,
              //   Colors.deepPurple
              // ])
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
          },context),
          buildListTile('Filter', Icons.settings,(){
            Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
          },context),
          buildListTile("Themes", Icons.color_lens, () {
            Navigator.of(context).pushReplacementNamed(ThemeScreen.routeName);

          }, context)
        ],
      ),
    );
  }
}
