import 'package:flutter/material.dart';

import '../../model/payment_model.dart';

class BusinessAccountScreen extends StatelessWidget {
  final PaymentModel user;

  BusinessAccountScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.userName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('User Name: ${user.userName}'),
            Text('Date: ${user.date}'),
            Text('Payment: ${user.payment}'),
            // Image.asset(user.avatar), // Assuming avatar is a path to an asset
          ],
        ),
      ),
    );
  }
}
