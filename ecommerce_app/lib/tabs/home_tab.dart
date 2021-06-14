import 'dart:ui';

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
                return GridView.count(
                  childAspectRatio: 7.5 / 10,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  padding: EdgeInsets.only(
                      top: 72 + MediaQuery.of(context).padding.top),
                  children: snapshot.data.docs.map((document) {
                    Product product = Product.fromData(document.data());
                    return GestureDetector(
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
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 170,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  '${product.images[0]}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text(
                                "\$${product.price}" ?? 'Price',
                                style: Constants.homeProductCardPrice,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 8.0),
                              child: Text(
                                document.data()['name'] ?? 'Product Name',
                                textDirection: TextDirection.ltr,
                                maxLines: 1,
                                style: Constants.smallRegularHeading,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
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
            title: 'Home',
            hasBackArrow: false,
            uid: _firebaseServices.getUserId(),
          ),
        ],
      ),
    );
  }
}
