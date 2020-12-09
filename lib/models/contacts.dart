class Contact {
  int id;
  String firstName;
  String lastName;
  String phNumber;
  String address;
  String city;
  int pincode;
  String gender;
  String languagesKnown;
  DateTime birthDate;

  Contact(
      {this.firstName,
      this.lastName,
      this.phNumber,
      this.address,
      this.city,
      this.pincode,
      this.gender,
      this.languagesKnown,
      this.birthDate});
  Contact.withId(
      {this.id,
      this.firstName,
      this.lastName,
      this.phNumber,
      this.address,
      this.city,
      this.pincode,
      this.gender,
      this.languagesKnown,
      this.birthDate});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['phNumber'] = phNumber;
    map['address'] = address;
    map['city'] = city;
    map['pincode'] = pincode;
    map['gender'] = gender;
    map['languagesKnown'] = languagesKnown;
    map['date'] = birthDate.toIso8601String();
    return map;
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact.withId(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phNumber: map['phNumber'],
      address: map['address'],
      city: map['city'],
      pincode: map['pincode'],
      gender: map['gender'],
      languagesKnown: map['languagesKnown'],
      birthDate: DateTime.parse(map['date']),
    );
  }
}
