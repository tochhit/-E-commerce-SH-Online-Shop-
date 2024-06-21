import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/authenticantion/logout/logout_controller.dart';
import 'package:ecommerce/features/personalization/screens/address/address.dart';
import 'package:ecommerce/features/shop/screens/cart/cart.dart';
import 'package:ecommerce/features/shop/screens/order/order.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../test_screen/delivery/delivery.dart';
import '../../../../test_screen/delivery/language.dart';
import '../../../../test_screen/delivery/notification.dart';
import '../../../../test_screen/payment.dart';
import '../../../shop/screens/about/about.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogoutController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    TAppBar(title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white))),

                    /// User Profile Card
                    TUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
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
                      onTap: () => Get.to(() => const UserAddressScreen()),
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: 'My Cart',
                      subTitle: 'Add, remove products and move to checkout',
                      onTap: () => Get.to(() => const CartScreen()),
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: 'My Orders',
                      subTitle: 'In-progress and Completed Orders',
                      onTap: () => Get.to(() => const OrderScreen()),
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.truck,
                      title: 'Delivery',
                      subTitle: 'Track deliveries and View deliveries',
                      onTap: () =>Get.to(() => const DeliveryScreen()),
                    ),
                    TSettingsMenuTile(
                        icon: Iconsax.card,
                        title: 'Payment Methods',
                        subTitle: 'add Payment and credit card details',
                        onTap: () => Get.to(() => const PaymentMethodsScreen()),
                    ),
                    TSettingsMenuTile(
                        icon: Iconsax.notification,
                        title: 'Notifications',
                        subTitle: 'Set any kind of notification message',
                        onTap: () => Get.to(() => const NotificationScreen()),
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
                      onTap: () => Get.to(const LanguageScreen()),
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
                      child: OutlinedButton(onPressed: () => controller.logout(), child: const Text('Logout')),
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

