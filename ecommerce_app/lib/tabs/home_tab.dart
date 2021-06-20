import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/custom_action_bar.dart';
import 'package:ecommerce_app/widgets/home_tab_product_card.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeTab extends StatelessWidget {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  return HomeTabProductCard(document: document);
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
        ),
      ],
    );
  }
}
