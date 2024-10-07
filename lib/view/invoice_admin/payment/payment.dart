import 'package:invoice_management_system_flutter_ui/imports.dart';
import '../../../model/User_and_Business.dart';
import '../../Multiple_Business_Accounts/Business_Accounts_screen.dart';
import '../../Multiple_Business_Accounts/Multipale_account_screen.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<StatefulWidget> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final pay = PaymentController();
  final user = User(
    id: 'user1',
    name: 'John Doe',
    businesses: [
      Business(id: 'biz1', name: 'Business One'),
      Business(id: 'biz2', name: 'Business Two'),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          shrinkWrap: true,
          itemCount: pay.paymentList.length,
          itemBuilder: (BuildContext context, int i) {
            return PaymentCardTile(
              data: pay.paymentList[i],
              onTap: () {
                // Navigate to the BusinessAccountScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultipleBusinessAccountsScreen(user: user),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
