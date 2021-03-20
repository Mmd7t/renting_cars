import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renting_cars/providers/accent_color_provider.dart';
import 'package:renting_cars/providers/theme_provider.dart';

import '../../constants.dart';

class SettingsTileThree extends StatefulWidget {
  @override
  _SettingsTileThreeState createState() => _SettingsTileThreeState();
}

class _SettingsTileThreeState extends State<SettingsTileThree> {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var accentColor = Provider.of<AccentColorProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: (theme.theme)
            ? c1
            : Theme.of(context).primaryColor.withOpacity(0.3),
      ),
      child: SwitchListTile(
        title: Text(
          'Dark Theme',
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: colorsMap[accentColor.color],
                fontWeight: FontWeight.bold,
              ),
        ),
        inactiveTrackColor: colorsMap[accentColor.color].withOpacity(0.3),
        activeColor: colorsMap[accentColor.color],
        value: theme.theme,
        onChanged: (value) {
          setState(() {
            theme.setDarkTheme(value);
          });
        },
      ),
    );
  }
}
