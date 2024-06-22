import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();

  RxBool isDarkMode = false.obs;

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(theme);
  }
}
