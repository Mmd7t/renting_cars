import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:renting_cars/constants.dart';
import 'package:renting_cars/db/db.dart';
import 'package:renting_cars/models/rent_car.dart';
import 'package:renting_cars/models/utility.dart';
import 'package:renting_cars/providers/accent_color_provider.dart';
import 'package:renting_cars/widgets/add_image_box.dart';
import 'package:renting_cars/widgets/global_textfield.dart';

class AddRentDataPage extends StatefulWidget {
  static const String routeName = 'addRentDataPage';
  @override
  _AddRentDataPageState createState() => _AddRentDataPageState();
}

class _AddRentDataPageState extends State<AddRentDataPage> {
  TextEditingController phoneNum, priceInDay, priceInMonth;
  String carName = 'Kia';
  String cityName = 'Cairo';
  var _formKey = GlobalKey<FormState>();

/*--------------------------------------  Images Part  --------------------------------------*/

  File carImage, carLicenseImage;
  String carImageString = '', carLicenseImageString = '';
  final ImagePicker picker = ImagePicker();

  Future getCarImage() async {
    picker.getImage(source: ImageSource.gallery).then((pickedImage) {
      setState(() {
        carImage = File(pickedImage.path);
      });
      pickedImage.readAsBytes().then((value) {
        carImageString = Utility.base64String(value);
      });
    });
  }

  Future getCarLicenseImage() async {
    picker.getImage(source: ImageSource.gallery).then((pickedImage) {
      setState(() {
        carLicenseImage = File(pickedImage.path);
      });
      pickedImage.readAsBytes().then((value) {
        carLicenseImageString = Utility.base64String(value);
      });
    });
  }

  @override
  void initState() {
    phoneNum = TextEditingController();
    priceInDay = TextEditingController();
    priceInMonth = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var accentColor = Provider.of<AccentColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Data",
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: colorsMap[accentColor.color],
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
            color: Theme.of(context).accentColor,
            icon: const Icon(Icons.cancel_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            color: Colors.blueAccent,
            icon: const Icon(Icons.check),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                await DB.db.insertRentData(RentCar(
                  name: carName,
                  priceInDay: priceInDay.text,
                  phoneNumber: phoneNum.text,
                  priceInMonth: priceInMonth.text,
                  city: cityName,
                  carImage: carImageString,
                  carLicenseImage: carLicenseImageString,
                ));
                Navigator.pop(context, true);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
/*--------------------------------------------------------------------------------------------*/
/*------------------------------------  Car Name Input ---------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton(
                      value: carName,
                      onChanged: (value) {
                        setState(() {
                          carName = value;
                        });
                      },
                      isExpanded: true,
                      elevation: 2,
                      items: List.generate(
                        carsNamesList.length,
                        (index) => DropdownMenuItem(
                          child: Text(carsNamesList[index]),
                          value: carsNamesList[index],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*-----------------------------------  PriceInDay Input --------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  GlobalTextFormField(
                    controller: priceInDay,
                    hintText: 'Price in Day',
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*----------------------------------  PriceInMonth Input -------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  GlobalTextFormField(
                    controller: priceInMonth,
                    hintText: 'Price in Month',
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*-----------------------------------  PhoneNumber Input -------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  GlobalTextFormField(
                    controller: phoneNum,
                    hintText: 'Phone number',
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*-------------------------------------  City Input ------------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton(
                      value: cityName,
                      onChanged: (value) {
                        setState(() {
                          cityName = value;
                        });
                      },
                      isExpanded: true,
                      elevation: 2,
                      items: List.generate(
                        citiesNamesList.length,
                        (index) => DropdownMenuItem(
                          child: Text(citiesNamesList[index]),
                          value: citiesNamesList[index],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      carImageString == ''
                          ? AddImageBox(
                              text: "Car Image",
                              onPressed: () {
                                getCarImage();
                              },
                            )
                          : (carImage == null)
                              ? SizedBox()
                              : Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.43,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.27,
                                      child: Image.file(carImage),
                                    ),
                                    Positioned(
                                      bottom: -15,
                                      left: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            colorsMap[accentColor.color],
                                        maxRadius: 15,
                                        child: IconButton(
                                          icon: Icon(Icons.close),
                                          iconSize: 15,
                                          color: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              carImageString = '';
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                      carLicenseImageString == ''
                          ? AddImageBox(
                              text: "Car License Image",
                              onPressed: () {
                                getCarLicenseImage();
                              },
                            )
                          : (carLicenseImage == null)
                              ? SizedBox()
                              : Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.43,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.27,
                                      child: Image.file(carLicenseImage),
                                    ),
                                    Positioned(
                                      bottom: -15,
                                      left: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            colorsMap[accentColor.color],
                                        maxRadius: 15,
                                        child: IconButton(
                                          icon: Icon(Icons.close),
                                          iconSize: 15,
                                          color: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              carLicenseImageString = '';
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
