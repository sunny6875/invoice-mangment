import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:invoice_management_system_flutter_ui/Authentication/sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constant.dart';
import '../GlobalComponents/button_global.dart';
import '../Home/home_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    final url = 'https://freelancerbrain.com/wp-mg/wp-json/wp/v2/users/register';
    final response = await http.post(
      Uri.parse(url),
      body: {

        'email': _emailController.text,
        'password': _passwordController.text,
        'username': _usernameController.text,
        'address': _addressController.text,
      },
    );

    if (response.statusCode == 200) {
      // Registration successful, navigate to HomeScreen
      const HomeScreen().launch(context);
    } else {
      final responseData = json.decode(response.body);
      // Handle registration failure
      toast(responseData['message'] ?? 'Registration failed', gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Sign Up'.tr,
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Sign Up now to begin an amazing journey'.tr,
                  style: kTextStyle.copyWith(color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    AppTextField(
                      controller: _usernameController,
                      textFieldType: TextFieldType.NAME,
                      decoration: InputDecoration(
                        labelText: 'Username'.tr,
                        hintText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    AppTextField(
                      controller: _addressController,
                      textFieldType: TextFieldType.NAME,
                      decoration: InputDecoration(
                        labelText: 'Address'.tr,
                        hintText: 'Address',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    AppTextField(
                      controller: _emailController,
                      textFieldType: TextFieldType.EMAIL,
                      decoration: InputDecoration(
                        labelText: 'Email Address'.tr,
                        hintText: 'john.doe@example.com',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    AppTextField(
                      controller: _passwordController,
                      textFieldType: TextFieldType.PASSWORD,
                      decoration: InputDecoration(
                        labelText: 'Password'.tr,
                        hintText: 'Enter password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ButtonGlobal(
                      buttontext: 'Sign Up'.tr,
                      buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _register();
                        }
                      },
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Have an account?'.tr,
                            style: kTextStyle.copyWith(
                              color: kGreyTextColor,
                            ),
                          ),
                          WidgetSpan(
                            child: Text(
                              'Sign In'.tr,
                              style: kTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: kMainColor,
                              ),
                            ).onTap(() {
                              const SignIn().launch(context);
                            }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Or Sign Up With...'.tr,
                      style: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 12.0),
                    ),
                    Hero(
                      tag: 'social',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              elevation: 2.0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                                child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.facebookF,
                                    color: Color(0xFF3B5998),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                              child: Center(
                                child: Image.asset(
                                  'images/google.png',
                                  height: 25.0,
                                  width: 25.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              elevation: 2.0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                                child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.twitter,
                                    color: Color(0xFF3FBCFF),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
