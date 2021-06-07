class UserModel {
  String uid;
  String name;
  DateTime dateTime;
  String email;

  UserModel({this.uid, this.name, this.dateTime, this.email});

  UserModel.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        name = data['name'],
        dateTime = data['datetime'],
        email = data['email'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'datetime': dateTime,
      'email': email,
    };
  }
}
