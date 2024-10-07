import 'package:flutter/material.dart';

import '../../model/Subscriptionplan_model.dart';

class MonthlyPlanScreen extends StatelessWidget {
  final List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      name: 'Basic',
      price: 9.99,
      description: 'Up to 10 invoices per month.',
      maxInvoices: 10,
    ),
    SubscriptionPlan(
      name: 'Standard',
      price: 19.99,
      description: 'Up to 50 invoices per month.',
      maxInvoices: 50,
    ),
    SubscriptionPlan(
      name: 'Premium',
      price: 29.99,
      description: 'Unlimited invoices.',
      maxInvoices: -1, // -1 for unlimited
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Plans'),
      ),
      body: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(plan.name),
              subtitle: Text(plan.description),
              trailing: Text('\$${plan.price.toStringAsFixed(2)} / month'),
              onTap: () {
                // Handle plan selection
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Select Plan'),
                    content: Text('Do you want to select the ${plan.name} plan for \$${plan.price.toStringAsFixed(2)} per month?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle subscription logic here
                          Navigator.pop(context);
                        },
                        child: Text('Select'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
