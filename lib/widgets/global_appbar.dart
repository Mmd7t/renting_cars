import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renting_cars/pages/settings/settings.dart';

class GlobalAppBar extends PreferredSize {
  final bool isHome;
  final bool isSettings;
  final String title;

  const GlobalAppBar(
      {this.isHome = false,
      this.isSettings = false,
      this.title = 'Renting Cars'});
  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline5.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
      ),
      centerTitle: true,
      leading: (isHome)
          ? const SizedBox()
          : IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
      actions: [
        (isSettings)
            ? const SizedBox()
            : IconButton(
                color: Theme.of(context).accentColor,
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).pushNamed(Settings.routeName);
                },
              ),
      ],
    );
  }
}
