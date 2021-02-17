class UserModel {
  String uid;
  String name;
  String add1;
  String add2;
  int zipcode;
  String city;
  DateTime dateTime;
  String email;

  UserModel(
      {this.uid,
      this.name,
      this.add1,
      this.add2,
      this.zipcode,
      this.city,
      this.dateTime,
      this.email});

  UserModel.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        name = data['name'],
        add1 = data['add1'],
        add2 = data['add2'],
        zipcode = data['zipcode'],
        city = data['city'],
        dateTime = data['datetime'],
        email = data['email'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'add1': add1,
      'add2': add2,
      'city': city,
      'zipcode': zipcode,
      'datetime': dateTime,
      'email': email,
    };
  }
}
