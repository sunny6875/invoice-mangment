import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LanguageController extends GetxController {
  RxInt selectedLanguageIndex = RxInt(-1);
  //navigate
  void changeLanguage(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    final selectedLanguage = "${newLocale.languageCode}_${newLocale.countryCode}";
    Get.updateLocale(newLocale);
    prefs.setString("selectedLanguage", selectedLanguage);
  }
}