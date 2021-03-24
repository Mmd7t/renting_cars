import 'package:renting_cars/pages/home.dart';
import 'package:renting_cars/pages/lease_car/add_lease_data.dart';
import 'package:renting_cars/pages/lease_car/get_expected_cars.dart';
import 'package:renting_cars/pages/rent_car/show_rent_cars.dart';
import 'package:renting_cars/pages/settings/settings.dart';
import 'package:renting_cars/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/splash_screen.dart';
import 'providers/theme_provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // load the shared preferences from disk before the app is started
  final prefs = await SharedPreferences.getInstance();

  // create new theme controller, which will get the currently selected from shared preferences
  final themeController = ThemeController(prefs);

  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  final ThemeController themeController;

  const MyApp({Key key, this.themeController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ThemeControllerProvider(
      controller: themeController,
      child: MaterialApp(
        title: 'Renting Cars',
        debugShowCheckedModeBanner: false,
        theme: _buildCurrentTheme(),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          Home.routeName: (context) => Home(),
          Settings.routeName: (context) => Settings(),
          ShowRentCars.routeName: (context) => ShowRentCars(),
          AddLeaseDataPage.routeName: (context) => AddLeaseDataPage(),
          GetExpectedCars.routeName: (context) => GetExpectedCars(),
        },
      ),
    );
  }

  // build the flutter theme from the saved theme string
  ThemeData _buildCurrentTheme() {
    switch (themeController.currentTheme) {
      case "dark":
        return darkTheme;
      case "light":
      default:
        return lightTheme;
    }
  }
}
