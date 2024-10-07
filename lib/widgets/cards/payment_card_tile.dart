import 'package:flutter/material.dart';

import '../../model/payment_model.dart';

class PaymentCardTile extends StatelessWidget {
  final PaymentModel data;
  final VoidCallback onTap;

  PaymentCardTile({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // leading: Image.asset(data.avatar),
        title: Text(data.userName),
        subtitle: Text('Date: ${data.date}\nPayment: ${data.payment}'),
        onTap: onTap,
      ),
    );
  }
}
