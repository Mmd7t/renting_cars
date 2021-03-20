import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:renting_cars/db/db.dart';
import 'package:renting_cars/models/rent_car.dart';
import 'package:renting_cars/models/utility.dart';
import 'package:renting_cars/providers/accent_color_provider.dart';
import 'package:renting_cars/widgets/add_image_box.dart';
import 'package:renting_cars/widgets/global_textfield.dart';

import '../../constants.dart';

class EditRentDataPage extends StatefulWidget {
  final int id;
  final String city;
  final String name;
  final String priceInDay;
  final String priceInMonth;
  final String phoneNum;
  final String carImage;
  final String carLicenseImage;

  const EditRentDataPage({
    Key key,
    this.id,
    this.city,
    this.name,
    this.priceInDay,
    this.priceInMonth,
    this.phoneNum,
    this.carImage,
    this.carLicenseImage,
  }) : super(key: key);
  @override
  _EditRentDataPageState createState() => _EditRentDataPageState();
}

class _EditRentDataPageState extends State<EditRentDataPage> {
  TextEditingController priceInDayController = TextEditingController();
  TextEditingController priceInMonthController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  String carName;
  String cityName;
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
    super.initState();
    priceInDayController.text = widget.priceInDay;
    priceInMonthController.text = widget.priceInMonth;
    phoneNumController.text = widget.phoneNum;
    carImageString = widget.carImage;
    carLicenseImageString = widget.carLicenseImage;
    cityName = widget.city;
    carName = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    var accentColor = Provider.of<AccentColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Data",
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
                await DB.db.updateRentData(RentCar(
                  id: widget.id,
                  name: carName,
                  priceInDay: priceInMonthController.text,
                  phoneNumber: priceInDayController.text,
                  priceInMonth: phoneNumController.text,
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
                    controller: priceInDayController,
                    hintText: 'Price in Day',
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*----------------------------------  PriceInMonth Input -------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  GlobalTextFormField(
                    controller: priceInMonthController,
                    hintText: 'Price in Month',
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*-----------------------------------  PhoneNumber Input -------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  GlobalTextFormField(
                    controller: phoneNumController,
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
                          : Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.43,
                                  height:
                                      MediaQuery.of(context).size.height * 0.27,
                                  child: Utility.imageFromBase64String(
                                      carImageString),
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
                          : Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.43,
                                  height:
                                      MediaQuery.of(context).size.height * 0.27,
                                  child: Utility.imageFromBase64String(
                                      carLicenseImageString),
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
