import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_management_system_flutter_ui/Authentication/sign_up.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../GlobalComponents/button_global.dart';
import '../Home/home_screen.dart';
import '../constant.dart';
import 'forgot_password.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isChecked = false;

  Future<void> _login() async {
    final url = 'https://freelancerbrain.com/wp-mg/wp-json/jwt-auth/v1/token';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': _emailController.text,
        'password': _passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Login successful, navigate to HomeScreen
      const HomeScreen().launch(context);
    } else {
      // Handle login failure
      final responseData = json.decode(response.body);
      toast(responseData['message'] ?? 'Login failed', gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Sign In'.tr,
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Sign In now to begin an amazing journey'.tr,
                style: kTextStyle.copyWith(color: Colors.white),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    AppTextField(
                      controller: _emailController,
                      textFieldType: TextFieldType.EMAIL,
                      decoration: InputDecoration(
                        labelText: 'Email Address'.tr,
                        hintText: 'john.doe@example.com',
                        labelStyle: kTextStyle,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: const OutlineInputBorder(),
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
                        labelStyle: kTextStyle,
                        hintText: 'Enter password'.tr,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: isChecked,
                            thumbColor: kGreyTextColor,
                            onChanged: (bool value) {
                              setState(() {
                                isChecked = value;
                              });
                            },
                          ),
                        ),
                        Text(
                          'Save Me'.tr,
                          style: kTextStyle,
                        ),
                        const Spacer(),
                        Text(
                          'Forgot Password?'.tr,
                          style: kTextStyle,
                        ).onTap(() {
                          const ForgotPassword().launch(context);
                        }),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    ButtonGlobal(
                      buttontext: 'Sign In'.tr,
                      buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don\'t have an account?'.tr,
                            style: kTextStyle.copyWith(
                              color: kGreyTextColor,
                            ),
                          ),
                          WidgetSpan(
                            child: Text(
                              'Sign Up'.tr,
                              style: kTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: kMainColor,
                              ),
                            ).onTap(() {
                              const SignUp().launch(context);
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
