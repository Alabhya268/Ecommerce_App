import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/product_page.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/custom_action_bar.dart';
import 'package:ecommerce_app/widgets/custom_input.dart';
import 'package:ecommerce_app/widgets/home_tab_product_card.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          if (_searchString.isEmpty)
            Center(
              child: Text(
                'Search Results',
                style: Constants.regularDark,
              ),
            )
          else
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productsRef.orderBy('name').startAt(
                  [_searchString]).endAt(['$_searchString\uf8ff']).get(),
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
                        top: 140 + MediaQuery.of(context).padding.top),
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
            title: 'Search',
          ),
          CustomInput(
            padding: EdgeInsets.symmetric(
                vertical: 80 + MediaQuery.of(context).padding.top,
                horizontal: 8),
            hintText: 'Search here...',
            onChanged: (value) {
              setState(() {
                _searchString = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
