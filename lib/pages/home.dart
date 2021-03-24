import 'package:flutter/material.dart';
import 'package:renting_cars/pages/rent_car/show_rent_cars.dart';
import 'package:renting_cars/providers/theme_provider.dart';
import 'package:renting_cars/widgets/global_appbar.dart';

import '../constants.dart';
import 'lease_car/get_expected_cars.dart';

class Home extends StatelessWidget {
  static const String routeName = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(isHome: true, title: 'Renting Cars'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContainBox(
              title: "Car Owner",
              onTap: () {
                Navigator.of(context).pushNamed(ShowRentCars.routeName);
              },
            ),
            const SizedBox(height: 10),
            ContainBox(
              title: "Customer",
              onTap: () {
                Navigator.of(context).pushNamed(GetExpectedCars.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContainBox extends StatelessWidget {
  const ContainBox({
    Key key,
    this.title,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var themeController = ThemeController.of(context);
    final radius = BorderRadius.circular(20);

    return InkWell(
      borderRadius: radius,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: radius,
          color: (themeController.currentTheme == "dark")
              ? c1
              : Theme.of(context).primaryColor,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: (themeController.currentTheme == "dark")
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
