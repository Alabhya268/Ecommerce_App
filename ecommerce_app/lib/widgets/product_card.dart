import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/product_page.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final QueryDocumentSnapshot document;

  ProductCard({Key key, this.document}) : super(key: key);

  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(
              productId: document.data()['productid'],
            ),
          ),
        );
      },
      child: FutureBuilder<DocumentSnapshot>(
        future: _firebaseServices.productsRef
            .doc('${document.data()['productid']}')
            .get(),
        builder: (context, productSnap) {
          if (productSnap.hasError) {
            return Center(
              child: Container(
                child: Text('${productSnap.error}'),
              ),
            );
          }

          if (productSnap.connectionState == ConnectionState.done) {
            Map<String, dynamic> _productMap = productSnap.data.data();
            return Container(
              margin: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network(
                        '${_productMap['images'][0]}',
                        width: 70,
                        height: 70,
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.low,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_productMap['name']}',
                              style: Constants.regularDarkText,
                              overflow: TextOverflow.fade,
                            ),
                            Text(
                              '\$${_productMap['price']}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            Text(
                              'Size - ${document.data()['size']}',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline_outlined),
                    onPressed: () {
                      _firebaseServices.cartRef.doc('${document.id}').delete();
                    },
                  ),
                ],
              ),
            );
          }

          if (productSnap.connectionState == ConnectionState.waiting) {
            return Center(
              child: LinearProgressIndicator(
                minHeight: 1,
              ),
            );
          }
        },
      ),
    );
  }
}
