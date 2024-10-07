import 'dart:convert';

import 'package:http/http.dart' as http;

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';


class Weeklyemailreportsscreen extends StatefulWidget {
  const Weeklyemailreportsscreen({Key? key}) : super(key: key);

  @override
  _WeeklyemailreportsscreenState createState() => _WeeklyemailreportsscreenState();
}

class _WeeklyemailreportsscreenState extends State<Weeklyemailreportsscreen> {
  bool includeFinancialSummary = true;
  bool includeOutstandingInvoices = true;
  bool includeOtherInfo = true;
  void _saveSettings() {
    // Save settings logic
    // Send settings to backend or local storage
    // Implement email generation and sending logic
    print("Settings saved: \nFinancial Summary: $includeFinancialSummary\nOutstanding Invoices: $includeOutstandingInvoices\nOther Info: $includeOtherInfo");
  }
  // void _saveSettings() {
  //   final settings = {
  //     'includeFinancialSummary': includeFinancialSummary,
  //     'includeOutstandingInvoices': includeOutstandingInvoices,
  //     'includeOtherInfo': includeOtherInfo,
  //   };
  //
  //   sendReportSettings(settings).then((_) {
  //     // Handle successful request
  //     print("Settings saved and report generation triggered");
  //   }).catchError((error) {
  //     // Handle error
  //     print("Failed to send report generation request: $error");
  //   });
  // }


  Future<void> sendReportSettings(Map<String, bool> settings) async {
    final response = await http.post(
      Uri.parse('https://your-backend-service.com/generate-email-report'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(settings),
    );

    if (response.statusCode == 200) {
      print('Report generation request sent successfully');
    } else {
      throw Exception('Failed to send report generation request');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     const AddClient().launch(context);
      //   },
      //   backgroundColor: kMainColor,
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Transaction List',
          maxLines: 2,
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
              width: context.width(),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  SwitchListTile(
                    title: Text('Include Financial Summary'),
                    value: includeFinancialSummary,
                    onChanged: (bool value) {
                      setState(() {
                        includeFinancialSummary = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Include Outstanding Invoices'),
                    value: includeOutstandingInvoices,
                    onChanged: (bool value) {
                      setState(() {
                        includeOutstandingInvoices = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Include Other Information'),
                    value: includeOtherInfo,
                    onChanged: (bool value) {
                      setState(() {
                        includeOtherInfo = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveSettings,
                    child: Text('Save Settings and Generate Report'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


