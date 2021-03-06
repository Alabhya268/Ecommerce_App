class Product {
  String desc;
  List<dynamic> images;
  String name;
  int price;
  List<dynamic> size;

  Product({
    this.desc,
    this.images,
    this.name,
    this.price,
    this.size,
  });

  Product.fromData(Map<String, dynamic> data)
      : desc = data['desc'],
        name = data['name'],
        images = data['images'],
        price = data['price'],
        size = data['size'];

  Map<String, dynamic> toJson() {
    return {
      'desc': desc,
      'name': name,
      'images': images,
      'price': price,
      'size': size,
    };
  }
}
