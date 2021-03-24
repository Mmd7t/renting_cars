import 'package:flutter/material.dart';
import 'package:renting_cars/providers/theme_provider.dart';

import '../constants.dart';

class AddImageBox extends StatelessWidget {
  final String text;
  final Function onPressed;

  const AddImageBox({Key key, this.text, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var themeController = ThemeController.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      enableFeedback: true,
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width * 0.43,
        height: MediaQuery.of(context).size.height * 0.28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: (themeController.currentTheme == "dark")
              ? Border.fromBorderSide(BorderSide.none)
              : Border.all(color: Theme.of(context).accentColor),
          color: (themeController.currentTheme == "dark") ? c1 : Colors.white,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.camera, color: Theme.of(context).primaryColor),
              Text(
                text,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
