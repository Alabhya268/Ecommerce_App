import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/comment.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/saved.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/custom_action_bar.dart';
import 'package:ecommerce_app/widgets/custom_input.dart';
import 'package:ecommerce_app/widgets/image_swipe.dart';
import 'package:ecommerce_app/widgets/product_size.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  const ProductPage({Key key, this.productId}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  Cart cart;
  Saved saved;
  Comment comment;

  String _selectedProductSize = '0';
  String _comment = "";
  String name;

  @override
  void initState() {
    _getUserName();
    super.initState();
  }

  Future _getUserName() async {
   name = await _firebaseServices.usersRef.doc(_firebaseServices.getUserId()).get().then((value) => value.data()['name']);
   return name;
  }

  Future _addToComment() {
    comment = Comment(
      name: name.toString(),
      uid: _firebaseServices.getUserId(),
      productid: widget.productId,
      comment: _comment,
      datetime: Timestamp.now(),
    );
    return _firebaseServices.commentRef.doc().set(comment.toJson());
  }

  Future _addToCart() {
    cart = Cart(
        datetime: DateTime.now(),
        productid: widget.productId,
        size: _selectedProductSize,
        uid: _firebaseServices.getUserId());
    return _firebaseServices.cartRef.doc().set(cart.toJson());
  }

  Future _addToSaved() {
    saved = Saved(
        datetime: DateTime.now(),
        productid: widget.productId,
        size: _selectedProductSize,
        uid: _firebaseServices.getUserId());
    return _firebaseServices.savedRef.doc().set(saved.toJson());
  }

  

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> comments = _firebaseServices.commentRef
        .orderBy('datetime', descending: true)
        .snapshots();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Scaffold(
                  body: Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                    ),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Product documentData = Product.fromData(snapshot.data.data());

                List imageList = documentData.images;
                List productSizes = documentData.size;

                _selectedProductSize = productSizes[0];

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ImageSwipe(
                      imageList: imageList,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 24,
                        right: 24,
                        bottom: 4,
                      ),
                      child: Text(
                        '${documentData.name}' ?? 'Product Name',
                        style: Constants.boldHeading,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 24,
                      ),
                      child: Text(
                        '\$${documentData.price}' ?? 'Price',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 24,
                      ),
                      child: Text(
                        '${documentData.desc}' ?? 'Description',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 24,
                      ),
                      child: Text(
                        'Select Size',
                        style: Constants.regularDarkText,
                      ),
                    ),
                    ProductSize(
                      onSelected: (size) {
                        _selectedProductSize = size;
                      },
                      productSize: productSizes,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _addToSaved().then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Product Saved'),
                                    duration: Duration(
                                      seconds: 1,
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 16),
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                                color: Color(0xFF1D1D1D),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.bookmark_border_outlined,
                                color: Colors.white70,
                                size: 30,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _addToCart().then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Product added to cart'),
                                      duration: Duration(
                                        seconds: 1,
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 65,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1E1E1E),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    Constants.boxShadow,
                                  ],
                                ),
                                child: Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomInput(
                      hintText: 'Comment here...',
                      onChanged: (value) {
                        _comment = value;
                      },
                      onSubmitted: (value) {
                        _addToComment();
                        setState(() {
                          _comment = "";
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Comments',
                        style: Constants.boldHeading,
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: comments,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Container(
                              child: Text('${snapshot.error}'),
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          return Container(
                            height: 400,
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              children: snapshot.data.docs.map(
                                (commentData) {
                                  Comment comments =
                                      Comment.fromData(commentData.data());
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          '${comments.name}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          '${comments.comment}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 0.5,
                                        color: Colors.white,
                                        indent: 20,
                                        endIndent: 20,
                                      )
                                    ],
                                  );
                                },
                              ).toList(),
                            ),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Theme.of(context).accentColor,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                );
              }
            },
          ),
          CustomActionBar(
            hasBackArrow: true,
            hasTitle: false,
            uid: _firebaseServices.getUserId(),
          ),
        ],
      ),
    );
  }
}
