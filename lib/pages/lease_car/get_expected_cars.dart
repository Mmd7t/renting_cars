import 'package:flutter/material.dart';
import 'package:renting_cars/db/db.dart';
import 'package:renting_cars/models/lease_car.dart';
import 'package:renting_cars/models/utility.dart';
import 'package:renting_cars/pages/lease_car/add_lease_data.dart';
import 'package:renting_cars/pages/lease_car/search_car.dart';
import 'package:renting_cars/providers/theme_provider.dart';
import 'package:renting_cars/widgets/global_appbar.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants.dart';
import 'edit_lease_data.dart';

class GetExpectedCars extends StatefulWidget {
  static const String routeName = 'getExpectedCars';
  @override
  _GetExpectedCarsState createState() => _GetExpectedCarsState();
}

class _GetExpectedCarsState extends State<GetExpectedCars> {
  DB database = DB.db;
  int count = 0;
  List<LeaseCar> leaseCarsList;

  @override
  Widget build(BuildContext context) {
    var themeController = ThemeController.of(context);
    if (leaseCarsList == null) {
      leaseCarsList = [];
      updateListView();
    }
    return Scaffold(
      appBar: const GlobalAppBar(title: 'Lease Car'),
      body: FutureBuilder(
          future: database.getAllLeaseData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  LeaseCar leaseCar = snapshot.data[index];
                  return Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (themeController.currentTheme == "dark")
                          ? c1
                          : Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name ::    ${leaseCar.name}'),
                            const SizedBox(height: 5),
                            Text('Personal ID ::    ${leaseCar.personalId}'),
                            const SizedBox(height: 5),
                            Text('City ::    ${leaseCar.city}'),
                            const SizedBox(height: 10),
                            Text('Car Name ::    ${leaseCar.carName}'),
                            const SizedBox(height: 10),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.43,
                              height: MediaQuery.of(context).size.height * 0.28,
                              child: Utility.imageFromBase64String(
                                  leaseCar.idCardImage),
                            ),
                          ],
                        ),
/*------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------  Edit & Delete Part  -------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------*/
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                bool result = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => EditLeaseDataPage(
                                              id: this.leaseCarsList[index].id,
                                              name: this
                                                  .leaseCarsList[index]
                                                  .name,
                                              personalId: this
                                                  .leaseCarsList[index]
                                                  .personalId,
                                              city: this
                                                  .leaseCarsList[index]
                                                  .city,
                                              idCardImage: this
                                                  .leaseCarsList[index]
                                                  .idCardImage,
                                              carName: this
                                                  .leaseCarsList[index]
                                                  .carName,
                                            )));
                                if (result == true) {
                                  updateListView();
                                }
                              },
                              color: Theme.of(context).accentColor,
                            ),
/*-----------------------------------------------------------------------------------------------------*/
/*-------------------------------------------  Delete Icon  -------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                database.deleteLeaseData(
                                    this.leaseCarsList[index].id);
                                updateListView();
                              },
                              color: Theme.of(context).primaryColor,
                            ),
/*-----------------------------------------------------------------------------------------------------*/
/*-------------------------------------------  Search Icon  -------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
                            IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SearchCar(
                                      cityName: this.leaseCarsList[index].city,
                                      carName:
                                          this.leaseCarsList[index].carName,
                                    ),
                                  ),
                                );
                              },
                              color: Theme.of(context).accentColor,
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
/*-----------------------------------------------------------------------------------------------------*/
/*-------------------------------------------  Add Data Btn  ------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          bool result = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddLeaseDataPage()));
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
      Future<List<LeaseCar>> noteListFuture = database.getAllLeaseData();
      noteListFuture.then((value) {
        setState(() {
          this.leaseCarsList = value;
          this.count = value.length;
        });
      });
    });
  }
}
