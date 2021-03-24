import 'package:flutter/material.dart';
import 'package:renting_cars/pages/settings/tile_three.dart';
import 'package:renting_cars/widgets/global_appbar.dart';

class Settings extends StatelessWidget {
  static const String routeName = 'settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(isSettings: true, title: 'Settings'),
      body: Column(
        children: [
          const SizedBox(height: 10),
          SettingsTileThree(),
        ],
      ),
    );
  }
}
