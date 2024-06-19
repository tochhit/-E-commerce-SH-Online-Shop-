import 'package:ecommerce/user_no_login/screen/screen/u_home.dart';
import 'package:ecommerce/user_no_login/screen/screen/u_settings.dart';
import 'package:ecommerce/user_no_login/screen/screen/u_store.dart';
import 'package:ecommerce/user_no_login/screen/u_wishlist.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UNavigationMenu extends StatelessWidget {
  const UNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UNavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : Colors.white,
          indicatorColor: darkMode ? TColors.white.withOpacity(0.1) : TColors.black.withOpacity(0.1),


          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class UNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const UHomeScreen(),const UStoreScreen(), const UFavouriteScreen(), const USettingsScreen()];

}

