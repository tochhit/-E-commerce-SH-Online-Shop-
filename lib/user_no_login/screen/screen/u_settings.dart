import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/user_no_login/screen/screen/u_address.dart';
import 'package:ecommerce/user_no_login/screen/u_cart.dart';
import 'package:ecommerce/user_no_login/screen/screen/u_login.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/shop/screens/about/about.dart';

class USettingsScreen extends StatelessWidget {
  const USettingsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(const ULoginScreen()),
                    child: TAppBar(
                      title: Row(
                        children: [
                          const Icon(Icons.person, color: TColors.white), // Add the icon with desired color
                          const SizedBox(width: 5.0), // Add some spacing between icon and text
                          Text(
                            'Login Account',
                            style: TextStyle(
                              color: TColors.white,
                              fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
                              fontWeight: Theme.of(context).textTheme.headlineMedium!.fontWeight,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),


                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            ///  Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TSectionHeading(title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set shopping delivery address',
                    onTap: () => Get.to(() => const UAddressScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                    onTap: () => Get.to(() => const UCartScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-progress and Completed Orders',
                    onTap: () => Get.to(() => const ULoginScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.truck,
                    title: 'Delivery',
                    subTitle: 'Track deliveries and View deliveries',
                    onTap: () => Get.to(() => const ULoginScreen()),
                  ),
                  TSettingsMenuTile(
                      icon: Iconsax.card,
                      title: 'Add Payment',
                      subTitle: 'add Payment and credit card details',
                      onTap: () => Get.to(() => const ULoginScreen()),
                  ),
                  TSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subTitle: 'Set any kind of notification message',
                      onTap: () => Get.to(() => const ULoginScreen()),
                  ),


                  /// App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    subTitle: 'Set dark mode screen',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Icons.language,
                    title: 'Language',
                    subTitle: 'English',
                    onTap: (){},
                  ),
                  TSettingsMenuTile(
                    icon: Icons.warning_rounded,
                    title: 'About',
                    subTitle: 'About Us',
                    onTap: () => Get.to(const ContactUsScreen()),
                  ),

                  /// Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: () => Get.to(const ULoginScreen()), child: const Text('Login Account')),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

