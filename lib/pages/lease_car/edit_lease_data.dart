import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:renting_cars/db/db.dart';
import 'package:renting_cars/models/lease_car.dart';
import 'package:renting_cars/models/utility.dart';
import 'package:renting_cars/providers/accent_color_provider.dart';
import 'package:renting_cars/widgets/add_image_box.dart';
import 'package:renting_cars/widgets/global_textfield.dart';

import '../../constants.dart';

class EditLeaseDataPage extends StatefulWidget {
  final int id;
  final String city;
  final String name;
  final String personalId;
  final String idCardImage;
  final String carName;

  const EditLeaseDataPage({
    Key key,
    this.id,
    this.city,
    this.name,
    this.idCardImage,
    this.personalId,
    this.carName,
  }) : super(key: key);
  @override
  _EditLeaseDataPageState createState() => _EditLeaseDataPageState();
}

class _EditLeaseDataPageState extends State<EditLeaseDataPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController personalIdController = TextEditingController();
  String cityName, carName;
  var _formKey = GlobalKey<FormState>();

/*--------------------------------------  Images Part  --------------------------------------*/

  File idCardImage;
  String idCardImageString = '';
  final ImagePicker picker = ImagePicker();

  Future getCarImage() async {
    picker.getImage(source: ImageSource.gallery).then((pickedImage) {
      setState(() {
        idCardImage = File(pickedImage.path);
      });
      pickedImage.readAsBytes().then((value) {
        idCardImageString = Utility.base64String(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    personalIdController.text = widget.personalId;
    cityName = widget.city;
    idCardImageString = widget.idCardImage;
    carName = widget.carName;
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
                await DB.db.updateLeaseData(LeaseCar(
                  id: widget.id,
                  name: nameController.text,
                  personalId: personalIdController.text,
                  city: cityName,
                  idCardImage: idCardImageString,
                  carName: carName,
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
/*-------------------------------------  Name Input ------------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  GlobalTextFormField(
                    controller: nameController,
                    hintText: 'Name',
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*----------------------------------  Personal Id Input --------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  GlobalTextFormField(
                    controller: personalIdController,
                    hintText: 'Personal id',
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
                  idCardImageString == ''
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
                              width: MediaQuery.of(context).size.width * 0.43,
                              height: MediaQuery.of(context).size.height * 0.27,
                              child: Utility.imageFromBase64String(
                                  idCardImageString),
                            ),
                            Positioned(
                              bottom: -15,
                              left: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: colorsMap[accentColor.color],
                                maxRadius: 15,
                                child: IconButton(
                                  icon: Icon(Icons.close),
                                  iconSize: 15,
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      idCardImageString = '';
                                    });
                                  },
                                ),
                              ),
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
