import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/product_page.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeTab extends StatelessWidget {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef.get(),
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
                return ListView(
                  padding: EdgeInsets.only(
                      top: 72 + MediaQuery.of(context).padding.top),
                  children: snapshot.data.docs.map((document) {
                    Product product = Product.fromData(document.data());
                    return Container(
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFF1E1E1E),
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProductPage(
                                      productId: document.id,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: 350,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  '${product.images[0]}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    document.data()['name'] ?? 'Product Name',
                                    style: Constants.regularHeading,
                                  ),
                                  Text(
                                    "\$${product.price}" ?? 'Price',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
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
            title: 'Home',
            hasBackArrow: false,
            uid: _firebaseServices.getUserId(),
          ),
        ],
      ),
    );
  }
}
