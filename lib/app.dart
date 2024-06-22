import 'package:ecommerce/bindings/general_bindings.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/test_screen/dark_mod/theme_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController();
    return Obx(() {
      return GetMaterialApp(
        themeMode: themeController.theme,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        initialBinding: GeneralBinding(),
        getPages: AppRoutes.pages,
        /// Show Loader or Circular Progress Indicator meanwhile Authentication Repository is deciding to show relevant screen.
        home: const Scaffold(backgroundColor: TColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white))),
      );
    });
  }
}