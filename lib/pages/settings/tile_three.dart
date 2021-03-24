import 'package:flutter/material.dart';
import 'package:renting_cars/providers/theme_provider.dart';

import '../../constants.dart';

class SettingsTileThree extends StatefulWidget {
  @override
  _SettingsTileThreeState createState() => _SettingsTileThreeState();
}

class _SettingsTileThreeState extends State<SettingsTileThree> {
  @override
  Widget build(BuildContext context) {
    var themeController = ThemeController.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: (themeController.currentTheme == "dark")
            ? c1
            : Theme.of(context).primaryColor.withOpacity(0.3),
      ),
      child: SwitchListTile(
        title: Text(
          'Dark Theme',
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        inactiveTrackColor: Theme.of(context).accentColor.withOpacity(0.3),
        activeColor: Theme.of(context).accentColor,
        value: (themeController.currentTheme == "dark"),
        onChanged: (value) {
          setState(() {
            themeController.setTheme((value) ? "dark" : "light");
          });
        },
      ),
    );
  }
}
