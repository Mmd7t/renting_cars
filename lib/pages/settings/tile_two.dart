import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renting_cars/providers/accent_color_provider.dart';
import 'package:renting_cars/providers/theme_provider.dart';

import '../../constants.dart';

class SettingsTileTwo extends StatelessWidget {
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
      child: ListTile(
        title: Text(
          'Reset Accent Color',
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: colorsMap[accentColor.color],
                fontWeight: FontWeight.bold,
              ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: colorsMap[accentColor.color],
        ),
        onTap: () {
          accentColor.setColor(0);
        },
      ),
    );
  }
}
