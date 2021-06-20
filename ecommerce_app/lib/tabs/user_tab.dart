import 'package:ecommerce_app/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class UserTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomActionBar(
          title: 'User',
        ),
      ],
    );
  }
}
