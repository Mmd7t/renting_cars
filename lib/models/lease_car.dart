class LeaseCar {
  int id;
  String name;
  String personalId;
  String idCardImage;
  String city;
  String carName;

  LeaseCar({
    this.id,
    this.name,
    this.personalId,
    this.idCardImage,
    this.city,
    this.carName,
  });

  LeaseCar.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    personalId = map['personalId'];
    idCardImage = map['idCardImage'];
    city = map['city'];
    carName = map['carName'];
  }

  toMap() {
    return {
      'id': id,
      'name': name,
      'personalId': personalId,
      'idCardImage': idCardImage,
      'city': city,
      'carName': carName,
    };
  }
}
