import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renting_cars/db/db.dart';
import 'package:renting_cars/models/rent_car.dart';
import 'package:renting_cars/models/utility.dart';
import 'package:renting_cars/providers/accent_color_provider.dart';
import 'package:renting_cars/providers/theme_provider.dart';
import 'package:renting_cars/widgets/global_appbar.dart';
import 'package:sqflite/sqflite.dart';
import '../../constants.dart';
import 'add_rent_data.dart';
import 'edit_rent_data.dart';

class ShowRentCars extends StatefulWidget {
  static const String routeName = 'showRentCars';
  @override
  _ShowRentCarsState createState() => _ShowRentCarsState();
}

class _ShowRentCarsState extends State<ShowRentCars> {
  DB database = DB.db;
  int count = 0;
  List<RentCar> rentCarsList;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var accentColor = Provider.of<AccentColorProvider>(context);

    if (rentCarsList == null) {
      rentCarsList = [];
      updateListView();
    }
    return Scaffold(
      appBar: const GlobalAppBar(title: 'Rent Cars'),
      body: FutureBuilder(
          future: database.getAllRentData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  RentCar rentCar = snapshot.data[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (theme.theme)
                          ? c1
                          : Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name ::    ${rentCar.name}'),
                        const SizedBox(height: 5),
                        Text('Price in Day ::    ${rentCar.priceInDay}'),
                        const SizedBox(height: 5),
                        Text('Price in Month ::    ${rentCar.priceInMonth}'),
                        const SizedBox(height: 5),
                        Text('Phone number ::    ${rentCar.phoneNumber}'),
                        const SizedBox(height: 5),
                        Text('City ::    ${rentCar.city}'),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.43,
                              height: MediaQuery.of(context).size.height * 0.28,
                              child: Utility.imageFromBase64String(
                                  rentCar.carImage),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.43,
                              height: MediaQuery.of(context).size.height * 0.28,
                              child: Utility.imageFromBase64String(
                                  rentCar.carLicenseImage),
                            ),
                          ],
                        ),
/*----------------------------------------------------------------------------------------------------*/
/*---------------------------------------  Edit & Delete Part  ---------------------------------------*/
/*----------------------------------------------------------------------------------------------------*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                bool result = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => EditRentDataPage(
                                              id: this.rentCarsList[index].id,
                                              name:
                                                  this.rentCarsList[index].name,
                                              phoneNum: this
                                                  .rentCarsList[index]
                                                  .phoneNumber,
                                              priceInDay: this
                                                  .rentCarsList[index]
                                                  .priceInDay,
                                              priceInMonth: this
                                                  .rentCarsList[index]
                                                  .priceInMonth,
                                              city:
                                                  this.rentCarsList[index].city,
                                              carImage: this
                                                  .rentCarsList[index]
                                                  .carImage,
                                              carLicenseImage: this
                                                  .rentCarsList[index]
                                                  .carLicenseImage,
                                            )));
                                if (result == true) {
                                  updateListView();
                                }
                              },
                              color: colorsMap[accentColor.color],
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                database.deleteRentData(
                                    this.rentCarsList[index].id);
                                updateListView();
                              },
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: const CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorsMap[accentColor.color],
        child: const Icon(Icons.add),
        onPressed: () async {
          bool result = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddRentDataPage()));
          if (result == true) {
            updateListView();
            // await notelist();
          }
        },
      ),
    );
  }

  updateListView() {
    final Future<Database> futureDb = database.initDB();
    futureDb.then((value) {
      Future<List<RentCar>> noteListFuture = database.getAllRentData();
      noteListFuture.then((value) {
        setState(() {
          this.rentCarsList = value;
          this.count = value.length;
        });
      });
    });
  }
}
