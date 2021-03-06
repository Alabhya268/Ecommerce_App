import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/custom_action_bar.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  

  @override
  Widget build(BuildContext context) {

    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _firebaseServices.cartRef
                .where('uid', isEqualTo: _firebaseServices.getUserId())
                .orderBy('datetime', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Container(
                    child: Text('${snapshot.error}'),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.active) {
                return ListView(
                  padding: EdgeInsets.only(
                    top: 70 + statusBarHeight,
                    bottom: 12,
                  ),
                  children: snapshot.data.docs.map(
                    (document) {
                      return Column(
                        children: [
                          ProductCard(
                            document: document,
                            onPressed: () {
                              _firebaseServices.cartRef
                                  .doc('${document.id}')
                                  .delete();
                            },
                          ),
                        ],
                      );
                    },
                  ).toList(),
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
            title: 'Cart',
            uid: _firebaseServices.getUserId(),
          ),
        ],
      ),
    );
  }
}
