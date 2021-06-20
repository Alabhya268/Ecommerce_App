import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/product_page.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final QueryDocumentSnapshot document;
  final Function onPressed;

  ProductCard({Key key, this.document, this.onPressed}) : super(key: key);

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
            Product _productMap = Product.fromData(productSnap.data.data());
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 4),
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              '${_productMap.images[0]}',
                              fit: BoxFit.fitHeight,
                              filterQuality: FilterQuality.low,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_productMap.name}',
                                  softWrap: false,
                                  style: Constants.regularDark,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '\$${_productMap.price}',
                                  style: Constants.cartProductCardPrice,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (document.data()['size'] != null)
                                  Text(
                                    'Size - ${document.data()['size']}',
                                    style: Constants.cartProductCardSize,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline_outlined),
                    onPressed: onPressed,
                    color: Colors.white70,
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
          return null;
        },
      ),
    );
  }
}
