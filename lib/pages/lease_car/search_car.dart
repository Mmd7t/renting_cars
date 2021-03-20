import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renting_cars/db/db.dart';
import 'package:renting_cars/models/rent_car.dart';
import 'package:renting_cars/models/utility.dart';
import 'package:renting_cars/providers/theme_provider.dart';
import 'package:renting_cars/widgets/global_appbar.dart';

import '../../constants.dart';

class SearchCar extends StatefulWidget {
  final String cityName;
  final String carName;

  const SearchCar({Key key, this.cityName, this.carName}) : super(key: key);

  @override
  _SearchCarState createState() => _SearchCarState();
}

class _SearchCarState extends State<SearchCar> {
  DB database = DB.db;
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: const GlobalAppBar(title: "Search Car"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: c1,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "${widget.cityName} / ${widget.carName}",
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 15),
            FutureBuilder(
                future: database.getSpecifiedRentData2(
                    widget.cityName, widget.carName),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        RentCar rentCar = snapshot.data[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (theme.theme)
                                ? c1
                                : Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.3),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name ::   ${rentCar.name}'),
                              const SizedBox(height: 5),
                              Text('Price in Day ::   ${rentCar.priceInDay}'),
                              const SizedBox(height: 5),
                              Text(
                                  'Price in Month ::   ${rentCar.priceInMonth}'),
                              const SizedBox(height: 5),
                              Text('Phone number ::   ${rentCar.phoneNumber}'),
                              const SizedBox(height: 5),
                              Text('City ::   ${rentCar.city}'),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    height: MediaQuery.of(context).size.height *
                                        0.28,
                                    child: Utility.imageFromBase64String(
                                        rentCar.carImage),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    height: MediaQuery.of(context).size.height *
                                        0.28,
                                    child: Utility.imageFromBase64String(
                                        rentCar.carLicenseImage),
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
          ],
        ),
      ),
    );
  }
}
