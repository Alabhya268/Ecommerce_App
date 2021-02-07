import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/product_page.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/custom_input.dart';
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
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        if (_searchString.isEmpty)
          Center(
            child: Text(
              'Search Results',
              style: Constants.regularDarkText,
            ),
          )
        else
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef
                .orderBy('name')
                .startAt([_searchString]).endAt(['$_searchString\uf8ff']).get(),
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
                    top: 84 + MediaQuery.of(context).padding.top,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return Container(
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
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
                                  '${document.data()['images'][0]}',
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
                                    "\$${document.data()['price']}" ?? 'Price',
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
        Container(
          padding: const EdgeInsets.only(
            top: 45,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: CustomInput(
            horizontalPadding: 12.0,
            hintText: 'Search here...',
            onChanged: (value) {
              setState(() {
                _searchString = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
