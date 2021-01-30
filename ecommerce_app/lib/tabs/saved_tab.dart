import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text('Saved Tab'),
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
