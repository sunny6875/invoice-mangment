import 'package:invoice_management_system_flutter_ui/imports.dart';

import '../../Client_mangment/ClientDataManagementScreen.dart';
import '../../Monthly_plan/monthly_plan_screen.dart';
import '../../Weekly_Email_Reports/WeeklyEmailReportsScreen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final settings = SettingsController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: settings.list.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, i) {
            return SettingsCard(
              data: settings.list[i],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      switch (i) {
                        case 0:
                          return Employee();
                            case 1:
                          return ClientDataManagementScreen();

                        case 2:
                          return ProductHome();
                        case 3:
                          return const GSTHome();
                          case 4:
                          return   MonthlyPlanScreen();
                          case 5:
                          // return   WeeklyEmailReportsScreen();
                        default:
                          return const LoginScreen();
                      }
                    },
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
