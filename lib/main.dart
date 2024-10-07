import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home/home_screen.dart';
import 'Mystring.dart';
import 'Splash Screen/splash_screen.dart';
import 'languages.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // locale: Locale("pt", "PT"),
      fallbackLocale: Locale("en", "US"),
      translations: language(),
      title: 'Invoice menegment',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 253, 188, 51),
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/homeScreen': (BuildContext ctx) => HomeScreen(),
      },
    );
  }
}

class SplashScreen1 extends StatefulWidget {
  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 5, 32, 1),
      body: Center(
        child: Container(

          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: Color.fromRGBO(8, 5, 32, 1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color:
                const Color.fromARGB(137, 230, 220, 220).withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
