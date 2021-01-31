import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/custom_action_bar.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _firebaseServices.savedRef
                .where(
                  'uid',
                  isEqualTo: _firebaseServices.getUserId(),
                )
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
                    top: 100,
                    bottom: 12,
                  ),
                  children: snapshot.data.docs.map(
                    (document) {
                      return ProductCard(
                        document: document,
                        onPressed: () {
                          _firebaseServices.savedRef
                              .doc('${document.id}')
                              .delete();
                        },
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
            title: 'Saved',
            uid: _firebaseServices.getUserId(),
          ),
        ],
      ),
    );
  }
}
