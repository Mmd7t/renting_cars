import 'package:path/path.dart';
import 'package:renting_cars/models/lease_car.dart';
import 'package:renting_cars/models/rent_car.dart';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';

class DB {
  DB._();
  static final DB db = DB._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
/*------------------------------------  Rent DB Table  ------------------------------------*/
        await db.execute('''
            CREATE TABLE $rentDbTable(
              id INTEGER PRIMARY KEY,
              name TEXT,
              phoneNumber TEXT,
              carImage TEXT,
              carLicenseImage TEXT,
              priceInDay TEXT,
              priceInMonth TEXT,
              city TEXT)
            ''');
/*------------------------------------------------------------------------------------------*/
/*------------------------------------  Lease DB Table  ------------------------------------*/
/*------------------------------------------------------------------------------------------*/
        await db.execute('''
            CREATE TABLE $leaseDbTable(
              id INTEGER PRIMARY KEY,
              name TEXT,
              personalId TEXT,
              idCardImage TEXT,
              city TEXT,
              carName TEXT)
            ''');
      },
    );
  }

  /*-----------------------  Insert into Rent DB Table ---------------------------*/

  insertRentData(RentCar data) async {
    final db = await database;
    var res = await db.insert(rentDbTable, data.toMap());
    return res;
  }

  /*-----------------------  Read from Rent DB Table  ---------------------------*/

  Future<List<RentCar>> getAllRentData() async {
    final db = await database;
    var res = await db.query(rentDbTable);
    List<RentCar> list =
        res.isNotEmpty ? res.map((c) => RentCar.fromMap(c)).toList() : [];
    return list;
  }

  /*-----------------------  Update Object in Rent DB Table  ---------------------------*/

  updateRentData(RentCar data) async {
    final db = await database;
    var res = await db.update(rentDbTable, data.toMap(),
        where: "id = ?", whereArgs: [data.id]);
    return res;
  }

  /*-----------------------  Delete Object from Rent DB Table  ---------------------------*/

  deleteRentData(int id) async {
    final db = await database;
    db.delete(rentDbTable, where: "id = ?", whereArgs: [id]);
  }
  /*-----------------------  Get Last Object from Rent DB Table  ---------------------------*/

  getSpecifiedRentData2(cityName, carName) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM $rentDbTable WHERE city LIKE '%$cityName%' AND  name LIKE '%$carName%'");
    List<RentCar> list =
        res.isNotEmpty ? res.map((c) => RentCar.fromMap(c)).toList() : [];
    return list;
  }
//
//
//
//
//
//
//
//
  /*-----------------------  Insert into Lease DB Table ---------------------------*/

  insertLeaseData(LeaseCar data) async {
    final db = await database;
    var res = await db.insert(leaseDbTable, data.toMap());
    return res;
  }

  /*-----------------------  Read from Lease DB Table  ---------------------------*/

  Future<List<LeaseCar>> getAllLeaseData() async {
    final db = await database;
    var res = await db.query(leaseDbTable);
    List<LeaseCar> list =
        res.isNotEmpty ? res.map((c) => LeaseCar.fromMap(c)).toList() : [];
    return list;
  }

  /*-----------------------  Update Object in Lease DB Table  ---------------------------*/

  updateLeaseData(LeaseCar data) async {
    final db = await database;
    var res = await db.update(leaseDbTable, data.toMap(),
        where: "id = ?", whereArgs: [data.id]);
    return res;
  }

  /*-----------------------  Delete Object from Lease DB Table  ---------------------------*/

  deleteLeaseData(int id) async {
    final db = await database;
    db.delete(leaseDbTable, where: "id = ?", whereArgs: [id]);
  }
}
