import 'package:flutter/material.dart';

/*------------------------------------  Light Theme  ---------------------------------------*/
ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: commonTheme.primaryColor,
  accentColor: commonTheme.accentColor,
  scaffoldBackgroundColor: Colors.white,
  dividerColor: commonTheme.dividerColor,
  inputDecorationTheme: commonTheme.inputDecorationTheme,
);

/*------------------------------------  Dark Theme  ---------------------------------------*/
ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: commonTheme.primaryColor,
  accentColor: commonTheme.accentColor,
  dividerColor: commonTheme.dividerColor,
  scaffoldBackgroundColor: Color(0xFF060C24),
  inputDecorationTheme: commonTheme.inputDecorationTheme,
);

/*------------------------------------  Common Theme  ---------------------------------------*/
var commonTheme = ThemeData(
  primaryColor: Colors.pink[700],
  accentColor: Colors.red,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 1.3,
      ),
    ),
  ),
);
