class RentCar {
  int id;
  String name;
  String phoneNumber;
  String carImage;
  String carLicenseImage;
  String priceInDay;
  String priceInMonth;
  String city;

  RentCar({
    this.id,
    this.name,
    this.phoneNumber,
    this.carImage,
    this.carLicenseImage,
    this.priceInDay,
    this.priceInMonth,
    this.city,
  });

  RentCar.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phoneNumber = map['phoneNumber'];
    carImage = map['carImage'];
    carLicenseImage = map['carLicenseImage'];
    priceInDay = map['priceInDay'];
    priceInMonth = map['priceInMonth'];
    city = map['city'];
  }

  toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'carImage': carImage,
      'carLicenseImage': carLicenseImage,
      'priceInDay': priceInDay,
      'priceInMonth': priceInMonth,
      'city': city,
    };
  }
}
