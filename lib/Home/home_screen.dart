// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:invoice_management_system_flutter_ui/Home/pricing_screen.dart';
import 'package:invoice_management_system_flutter_ui/Home/privacy_policy.dart';
import 'package:invoice_management_system_flutter_ui/Home/terms_of_service.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';

import '../../constant.dart';
import '../Authentication/profile_screen.dart';
import '../Authentication/sign_in.dart';
import '../Coustomer Management/empty_client_list.dart';
import '../Employee management/management_screen.dart';
import '../Invoice/Invoice.dart';
import '../Invoice/model/page/pdfpage.dart';
import '../Mystring.dart';
import '../Product/Product_list.dart';
import '../Settings/settings_screen.dart';
import '../Transation List/Transactionlist.dart';
import '../utils/app_colors.dart';
import '../view/Weekly_Email_Reports/WeeklyEmailReportsScreen.dart';
import '../view/invoice_admin/invoice/invoice.dart';
import '../view/side_nav.dart';
import 'languagescontroller.dart';
import 'legent.dart';

// ignore_for_file: library_private_types_in_public_api
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isChecked = false;
  int touchedIndex = -1;
  final pilateColor = AppColors.contentColorPurple;
  final cyclingColor = AppColors.contentColorCyan;
  final quickWorkoutColor = AppColors.contentColorBlue;
  final betweenSpace = 0.2;


  BarChartGroupData generateGroupData(
      int x,
      double pilates,
      double quickWorkout,
      double cycling,
      ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: pilates,
          color: pilateColor,
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + betweenSpace,
          toY: pilates + betweenSpace + quickWorkout,
          color: quickWorkoutColor,
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + betweenSpace + quickWorkout + betweenSpace,
          toY: pilates + betweenSpace + quickWorkout + betweenSpace + cycling,
          color: cyclingColor,
          width: 5,
        ),
      ],
    );
  }

  final LanguageController languageController = Get.put(LanguageController());
  void showLanguagePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choose your app language'.tr,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.2,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    languageController.selectedLanguageIndex.value = index;
                    // Get.find<LanguageController>().changeLanguage(locales[index]);
                    Get.find<LanguageController>().changeLanguage(
                        Locale(MyStrings.locales[index].toString()));
                  },
                  child: Obx(
                        () => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: languageController.selectedLanguageIndex.value ==
                            index
                            ? Colors.orange.withOpacity(0.1)
                            : Colors.blue.withOpacity(0.1),
                        border: Border.all(
                          color:
                          languageController.selectedLanguageIndex.value ==
                              index
                              ? Colors.orange
                              : Colors.transparent,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(MyStrings.LanguageName[index]),
                          Text(MyStrings.LanguageEnglish[index]),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange),
                onPressed: () {
                  Get.back();
                },
                child: Text('Close'.tr))
          ],
        );
      },
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'JAN';
        break;
      case 1:
        text = 'FEB';
        break;
      case 2:
        text = 'MAR';
        break;
      case 3:
        text = 'APR';
        break;
      case 4:
        text = 'MAY';
        break;
      case 5:
        text = 'JUN';
        break;
      case 6:
        text = 'JUL';
        break;
      case 7:
        text = 'AUG';
        break;
      case 8:
        text = 'SEP';
        break;
      case 9:
        text = 'OCT';
        break;
      case 10:
        text = 'NOV';
        break;
      case 11:
        text = 'DEC';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Invoice Management'.tr,
          maxLines: 2,
          style: kTextStyle.copyWith(color: Colors.white, fontSize: 16.0),
        ),
         actions: [
           IconButton(
             icon: Padding(
               padding: const EdgeInsets.only(right: 10.0),
               child: Icon(
                 Icons.translate_rounded,
                 color: Colors.white,
               ),
             ),
             onPressed: () {
               showLanguagePopup(context);

               // Add your notification icon press logic here
             },
           ),
         ],


      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: Get.height / 3,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
                color: kMainColor,
              ),
              child: Column(
                children: [
                  Container(
                    height: Get.height / 4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          const CircleAvatar(
                            radius: 60.0,
                            backgroundColor: kMainColor,
                            backgroundImage: AssetImage(
                              'images/emp1.png',
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'joinl ',
                            style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Admin',
                            style: kTextStyle.copyWith(color: kGreyTextColor),
                          ),
                        ],
                      ).onTap(() {
                        const ProfileScreen().launch(context);
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '27',
                            style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Employees',
                            style: kTextStyle.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '12',
                            style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Client',
                            style: kTextStyle.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '50',
                            style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Total Files',
                            style: kTextStyle.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ListTile(
              onTap: () {
                // const SettingScree().launch(context);
                 PdfPage().launch(context);
              },
              leading: const Icon(
                Icons.settings,
                color: kGreyTextColor,
              ),
              title: Text(
                'Settings',
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                const PricingScreen().launch(context);
              },
              leading: const Icon(
                FontAwesomeIcons.medal,
                color: kGreyTextColor,
              ),
              title: Text(
                'Premium Version',
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                const ProductList().launch(context);
              },
              leading: const Icon(
                FontAwesomeIcons.productHunt,
                color: kGreyTextColor,
              ),
              title: Text(
                'Product',
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),  ListTile(
              onTap: () {
              const Transactionlist().launch(context);
              },
              leading: const Icon(
                FontAwesomeIcons.list,
                color: kGreyTextColor,
              ),
              title: Text(
                'Transaction List',
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            // ListTile(
            //   onTap: () {
            //
            // const InvoiceList().launch(context);
            //   },
            //   leading: const Icon(
            //     FontAwesomeIcons.coffee,
            //     color: kGreyTextColor,
            //   ),
            //   title: Text(
            //     'Quotations',
            //     style: kTextStyle.copyWith(color: kGreyTextColor),
            //   ),
            //   trailing: const Icon(
            //     Icons.arrow_forward_ios,
            //     color: kGreyTextColor,
            //   ),
            // ),
            ListTile(
              onTap: () {
                const InvoiceList().launch(context);

                // const EmptyHoliday().launch(context);
              },
              leading: const Icon(
                FontAwesomeIcons.listCheck,
                color: kGreyTextColor,
              ),
              title: Text(
                'Invoice',
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                // const EmptyHoliday().launch(context);
              },
              leading: const Icon(
                FontAwesomeIcons.expand,
                color: kGreyTextColor,
              ),
              title: Text(
                'Expenses',
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                // const EmptyHoliday().launch(context);
              },
              leading: const Icon(
                FontAwesomeIcons.repeat,
                color: kGreyTextColor,
              ),
              title: Text(
                'Report',
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),     ListTile(
              onTap: () {
           const Weeklyemailreportsscreen().launch(context);
              },
              leading: const Icon(
                FontAwesomeIcons.repeat,
                color: kGreyTextColor,
              ),
              title: Text(
                'Weekly email reports',
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),


            ListTile(
              onTap: () {
                const TermsOfServices().launch(context);
              },
              leading: const Icon(
                FontAwesomeIcons.infoCircle,
                color: kGreyTextColor,
              ),
              title: Text(
                'Terms of Services',
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                const PrivacyPolicy().launch(context);
              },
              leading: const Icon(
                Icons.dangerous_sharp,
                color: kGreyTextColor,
              ),
              title: Text(
                'Privacy Policy',
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {


               const  SignIn().launch(context);

              },
              leading: const Icon(
                FontAwesomeIcons.signOutAlt,
                color: kGreyTextColor,
              ),
              title: Text(
                'Logout',
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: Get.height,
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Row(
                children: [
                  Expanded(
                    child: Material(
                      elevation: 2.0,
                      child: GestureDetector(
                        onTap: () {
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Color(0xFF7C69EE),
                                width: 3.0,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(  Icons.list_alt_outlined,),
                                    Text('₹ 100,050')
                                  ],
                                ),
                              ),                                  Text(
                                'Total Amount',
                                style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Material(
                      elevation: 2.0,
                      child: GestureDetector(
                        onTap: () {
                          // const ExpenseManagementScreen().launch(context);
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.blueAccent,
                                width: 3.0,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(  Icons.list_alt_outlined,),
                                    Text('₹ 150,050')
                                  ],
                                ),
                              ),
                              Text(
                               ' Total Paid',
                                style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      elevation: 2.0,
                      child: GestureDetector(
                        onTap: () {
                          const EmployeeManagement().launch(context);
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.red,
                                width: 3.0,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(  Icons.list_alt_outlined,),
                                    Text('₹ 100,050')
                                  ],
                                ),
                              ),                                  Text(
                                'Total Due',
                                style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Material(
                      elevation: 2.0,
                      child: GestureDetector(
                        onTap: () {

                          // const ExpenseManagementScreen().launch(context);
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Color(0xFFFD72AF),
                                width: 3.0,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(  Icons.people_alt_outlined,),
                                    Text('50')
                                  ],
                                ),
                              ),
                              Text(
                               ' Total Customer',
                                style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      elevation: 2.0,
                      child: GestureDetector(
                        onTap: () {
                          // const PayrollManagementScreen().launch(context);
                        },
                        child: Container(
                          width:Get.width,
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Color(0xFF4ACDF9),
                                width: 3.0,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(  Icons.inventory_outlined,),
                                   Text('₹ 40,050')
                                  ],
                                ),
                              ),                                  Text(
                                'Total Invoice',
                                style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Material(
                      elevation: 2.0,
                      child: GestureDetector(
                        onTap: () {
                          // const EmptyFileManagement().launch(context);
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.amber,
                                width: 3.0,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(  Icons.production_quantity_limits,),
                                    Text( '20',)
                                  ],
                                ),
                              ),                                     Text(
                                'Total Product',
                                maxLines: 2,
                                style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),Row(
                children: [
                  Expanded(
                    child: Material(
                      elevation: 2.0,
                      child: GestureDetector(
                        onTap: () {
                          // const PayrollManagementScreen().launch(context);
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.green,
                                width: 3.0,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(  Icons.inventory_outlined,),
                                   Text('50')
                                  ],
                                ),
                              ),                                  Text(
                                'Paid Invoice',
                                style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Material(
                      elevation: 2.0,
                      child: GestureDetector(
                        onTap: () {
                          // const EmptyFileManagement().launch(context);
                        },
                        child: Container(
                          width:Get.width,
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.red,
                                width: 3.0,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(  Icons.inventory_outlined,),
                                    Text( '5',)
                                  ],
                                ),
                              ),                                     Text(
                                'Due Invoice',
                                maxLines: 2,
                                style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Material(
                elevation: 2.0,
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFF4DCEFA),
                        width: 3.0,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    onTap: () {
                      const EmptyCostomerList().launch(context);
                    },
                    leading: const Image(image: AssetImage('images/clientmanagement.png')),
                    title: Text(
                      'Customer Management',
                      maxLines: 2,
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

              Material(
                elevation: 2.0,
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFFFF8919),
                        width: 3.0,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    onTap: () {
                      const EmployeeManagement().launch(context);
                    },
                    leading: const Image(image: AssetImage('images/noccertificate.png')),
                    title: Text(
                      'Employee Management',
                      maxLines: 2,
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
      Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Activity',
              style: TextStyle(
                color: AppColors.contentColorBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LegendsListWidget(
              legends: [
                Legend('Pilates', pilateColor),
                Legend('Quick workouts', quickWorkoutColor),
                Legend('Cycling', cyclingColor),
              ],
            ),
            const SizedBox(height: 14),
            AspectRatio(
              aspectRatio: 2,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 20,
                      ),
                    ),
                  ),
                  barTouchData: BarTouchData(enabled: false),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  barGroups: [
                    generateGroupData(0, 2, 3, 2),
                    generateGroupData(1, 2, 5, 1.7),
                    generateGroupData(2, 1.3, 3.1, 2.8),
                    generateGroupData(3, 3.1, 4, 3.1),
                    generateGroupData(4, 0.8, 3.3, 3.4),
                    generateGroupData(5, 2, 5.6, 1.8),
                    generateGroupData(6, 1.3, 3.2, 2),
                    generateGroupData(7, 2.3, 3.2, 3),
                    generateGroupData(8, 2, 4.8, 2.5),
                    generateGroupData(9, 1.2, 3.2, 2.5),
                    generateGroupData(10, 1, 4.8, 3),
                    generateGroupData(11, 2, 4.4, 2.8),
                  ],
                  maxY: 11 + (betweenSpace * 3),
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: 3.3,
                        color: pilateColor,
                        strokeWidth: 1,
                        dashArray: [20, 4],
                      ),
                      HorizontalLine(
                        y: 8,
                        color: quickWorkoutColor,
                        strokeWidth: 1,
                        dashArray: [20, 4],
                      ),
                      HorizontalLine(
                        y: 11,
                        color: cyclingColor,
                        strokeWidth: 1,
                        dashArray: [20, 4],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      AspectRatio(
        aspectRatio: 1.3,
        child: AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: showingSections(),
            ),
          ),
        ),
      ),
              LegendsListWidget(
                legends: [
                  Legend('Total Amount', Colors.purple),
                  Legend('Total Paid', Colors.blue),
                  Legend('Total Due', Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 100.0 : 80.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.purple,
            value: 100050,
            title: '100050',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blueAccent,
            value: 150050,
            title: '150050',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.red,
            value: 100050,
            title: '100050',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.contentColorGreen,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
