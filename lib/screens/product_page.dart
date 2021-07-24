import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/comment.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/saved.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/custom_action_bar.dart';
import 'package:ecommerce_app/widgets/custom_btn.dart';
import 'package:ecommerce_app/widgets/custom_icon_btn.dart';
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
    name = await _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .get()
        .then((value) => value.data()['name']);
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

  Future<void> _deleteComment(String uid) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF1E1E1E),
          title: Text(
            'Alert Dialog',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Do you want to delete this comment ?',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onPressed: () {
                _firebaseServices.commentRef.doc(uid).delete();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No',
                  style: TextStyle(color: Theme.of(context).accentColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateComment(String uid, String comment) {
    return _firebaseServices.commentRef
        .doc(uid)
        .update({'comment': comment})
        .then((value) => print("Comment Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> _updateCommentDialog(String uid, String initComment) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        String comment;
        return AlertDialog(
          backgroundColor: Color(0xFF1E1E1E),
          title: Text(
            'Alert Dialog',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  initialValue: initComment,
                  onChanged: (value) => comment = value,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: Text(
                  'Update',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () {
                  _updateComment(uid, comment);
                  Navigator.of(context).pop();
                }),
            TextButton(
              child: Text('Cancel',
                  style: TextStyle(color: Theme.of(context).accentColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> comments = _firebaseServices.commentRef
        .where('productid', isEqualTo: widget.productId)
        .orderBy('datetime', descending: true)
        .limit(5)
        .snapshots();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error: ${snapshot.error}",
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Product documentData = Product.fromData(snapshot.data.data());

                List imageList = documentData.images;
                List productSizes = documentData.size;

                _selectedProductSize = productSizes[0];

                return ListView(
                  padding: EdgeInsets.only(top: 0),
                  children: [
                    ImageSwipe(
                      imageList: imageList,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 12,
                        right: 12,
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
                        horizontal: 12,
                      ),
                      child: Text(
                        '\$${documentData.price}' ?? 'Price',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      child: Text(
                        '${documentData.desc}' ?? 'Description',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 12,
                      ),
                      child: Text(
                        'Select Size',
                        style: Constants.regularDark,
                      ),
                    ),
                    ProductSize(
                      onSelected: (size) {
                        _selectedProductSize = size;
                      },
                      productSize: productSizes,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 24),
                      child: Row(
                        children: [
                          CustomIconBtn(
                            margin: EdgeInsets.only(right: 16),
                            icon: Icon(
                              Icons.bookmark_border_outlined,
                              color: Colors.white70,
                              size: 30,
                            ),
                            onPressed: () {
                              _addToSaved().whenComplete(
                                () {
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Product Saved'),
                                        duration: Duration(
                                          seconds: 1,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          Expanded(
                            child: CustomBtn(
                                text: 'Add to cart',
                                onPressed: () {
                                  _addToCart().then(
                                    (value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Product added to cart'),
                                          duration: Duration(
                                            seconds: 1,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    CustomBtn(
                      padding: EdgeInsets.only(bottom: 12, left: 12, right: 12),
                      text: 'Buy Now',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12),
                      child: Text(
                        'Reviews',
                        style: Constants.boldHeading,
                      ),
                    ),
                    CustomInput(
                      hintText: 'Write your review here...',
                      onChanged: (value) {
                        _comment = value;
                      },
                      onFieldSubmitted: (value) {
                        _addToComment();
                        setState(() {
                          _comment = "";
                        });
                      },
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
                          return ConstrainedBox(
                            constraints: new BoxConstraints(
                              maxHeight: 500.0,
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: ListView(
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                children: snapshot.data.docs.map(
                                  (commentData) {
                                    Comment comments =
                                        Comment.fromData(commentData.data());
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            '${comments.name}',
                                            style: Constants.regularDark,
                                          ),
                                          subtitle: Text(
                                            '${comments.comment}',
                                            style: Constants.regularDarkLight,
                                          ),
                                          trailing: comments.uid ==
                                                  _firebaseServices.getUserId()
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons.edit_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    _updateCommentDialog(
                                                        commentData.id,
                                                        comments.comment);
                                                  })
                                              : null,
                                          onLongPress: () async {
                                            if (comments.uid ==
                                                _firebaseServices.getUserId()) {
                                              await _deleteComment(
                                                  commentData.id);
                                            }
                                          },
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
                            ),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Constants.regularProgressIndicator,
                          );
                        }
                        return null;
                      },
                    ),
                  ],
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Constants.regularProgressIndicator,
                );
              }
              return null;
            },
          ),
          CustomActionBar(
            hasBackArrow: true,
            hasTitle: false,
          ),
        ],
      ),
    );
  }
}
