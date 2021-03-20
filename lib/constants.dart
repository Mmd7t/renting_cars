import 'dart:ui';

import 'package:flutter/material.dart';

const String dbName = "rentingCar.db";
const String rentDbTable = "rent";
const String leaseDbTable = "lease";

const Map<int, Color> colorsMap = {
  0: Colors.blue,
  1: Colors.indigo,
  2: Colors.amber,
  3: Colors.teal,
  4: Colors.deepPurple,
  5: Colors.cyan,
  6: Colors.lightBlueAccent,
  7: Colors.orange,
  8: Colors.lightGreen,
};

const Color c1 = Color(0xFF1A1538);
const List carsNamesList = ['Kia', 'Hundai', 'BMW', 'Ford', 'Mercedes'];
const List citiesNamesList = ['Cairo', 'Giza', 'Minofia', 'Mansora', 'Alex'];
