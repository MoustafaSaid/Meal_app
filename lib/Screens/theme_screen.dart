import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  static const routeName = '/themes';

  const ThemeScreen({Key? key}) : super(key: key);

  Widget buildRadioListTile(
      ThemeMode themeMode, String text, IconData? icon, BuildContext context) {
    return RadioListTile(
      value: themeMode,
      groupValue: Provider.of<ThemeProvider>(context).themeMode,
      onChanged: (newThemeVal) =>
          Provider.of<ThemeProvider>(context, listen: false)
              .themeModeChange(newThemeVal),
      title: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title:const Text("Your Theme"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Adjust your theme selection.",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Choose your theme Mode.",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              buildRadioListTile(
                  ThemeMode.system, "System Default Theme", null, context),
              buildRadioListTile(ThemeMode.light, "Light Theme",
                  Icons.wb_sunny_outlined, context),
              buildRadioListTile(ThemeMode.dark, "Dark Theme",
                  Icons.nights_stay_outlined, context),
              buildListTile(context, "primary"),
              buildListTile(context, "accent"),
            ],
          ))
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context, txt) {
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    return ListTile(
      title: Text(
        "Choose your $txt color",
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor: txt == "primary" ? primaryColor : accentColor,
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                elevation: 4,
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: txt == "primary"
                        ? Provider.of<ThemeProvider>(context, listen: true)
                            .primaryColor
                        : Provider.of<ThemeProvider>(context, listen: true)
                            .accentColor,
                    onColorChanged: (Color value) =>
                        Provider.of<ThemeProvider>(context, listen: false)
                            .onChanged(value, txt == "primary" ? 1 : 2),
                    colorPickerWidth: 300.0,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: false,
                    displayThumbColor: true,
                    labelTypes: [],
                  ),
                ),
              );
            });
      },
    );
  }
}
