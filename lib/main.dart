import 'package:renting_cars/pages/home.dart';
import 'package:renting_cars/pages/lease_car/add_lease_data.dart';
import 'package:renting_cars/pages/lease_car/get_expected_cars.dart';
import 'package:renting_cars/pages/rent_car/show_rent_cars.dart';
import 'package:renting_cars/pages/settings/settings.dart';
import 'package:renting_cars/providers/accent_color_provider.dart';
import 'package:renting_cars/providers/theme_provider.dart';
import 'package:renting_cars/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/splash_screen.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
        ChangeNotifierProvider<AccentColorProvider>(
            create: (context) => AccentColorProvider()),
      ],
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, value, child) {
            return MaterialApp(
              title: 'Renting Cars',
              debugShowCheckedModeBanner: false,
              theme: value.theme ? darkTheme : lightTheme,
              initialRoute: SplashScreen.routeName,
              routes: {
                SplashScreen.routeName: (context) => SplashScreen(),
                Home.routeName: (context) => Home(),
                Settings.routeName: (context) => Settings(),
                ShowRentCars.routeName: (context) => ShowRentCars(),
                AddLeaseDataPage.routeName: (context) => AddLeaseDataPage(),
                GetExpectedCars.routeName: (context) => GetExpectedCars(),
              },
            );
          },
        );
      },
    );
  }
}
