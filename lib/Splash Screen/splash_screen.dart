// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../GlobalComponents/button_global.dart';
import '../../GlobalComponents/purchase_model.dart';
import '../../constant.dart';
import '../Home/home_screen.dart';
import '../Mystring.dart';
import 'on_board.dart';

// ignore_for_file: library_private_types_in_public_api
class SplashScreen extends StatefulWidget {
  const  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // _navigateToNextScreen();
    init();
  }
  Future<void> _navigateToNextScreen() async {
    // Simulate a delay for splash screen (you can replace it with actual loading tasks)
    await Future.delayed(Duration(seconds: 2));
    var sherefrifrence = await SharedPreferences.getInstance();
    var isLogin = sherefrifrence.getBool(MyStrings.keylogin);
    Timer(Duration(seconds: 2), () {
      if (isLogin != null) {
        if (isLogin) {
          // User is already logged in
          Get.offAll(HomeScreen());
        } else {
          // User is not logged in
          Get.offAll(SplashScreen());
        }
      } else {
        Get.offAll(SplashScreen());
      }
    });
  }
  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));

    defaultBlurRadius = 10.0;
    defaultSpreadRadius = 0.5;

    bool isValid = await PurchaseModel().isActiveBuyer();
    if(isValid){
      finish(context);
      const OnBoard().launch(context, isNewTask: true);
    } else{
      showLicense(context: context);
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            // const Image(
            //   image: AssetImage('images/round_logo.png'),
            // ),
            const Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Version 1.0.0',
                  style: GoogleFonts.manrope(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
