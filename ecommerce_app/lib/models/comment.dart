class Comment {
  String uid;
  String productid;
  String comment;
  String name;
  DateTime datetime;

  Comment({this.uid, this.productid, this.comment, this.datetime, this.name});

  Comment.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        productid = data['productid'],
        comment = data['comment'],
        datetime = data['datetime'],
        name = data['name'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'productid': productid,
      'comment': comment,
      'datetime': datetime,
      'name': name
    };
  }
}
