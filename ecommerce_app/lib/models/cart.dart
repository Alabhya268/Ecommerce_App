class Cart {
  DateTime datetime;
  String productid;
  String size;
  String uid;

  Cart({this.datetime, this.productid, this.size, this.uid});

  Cart.fromData(Map<String, dynamic> data)
      : datetime = data['datetime'],
        productid = data['productid'],
        size = data['size'],
        uid = data['uid'];

  Map<String, dynamic> toJson() {
    return {
      'datetime': datetime,
      'productid': productid,
      'size': size,
      'uid': uid,
    };
  }
}
