import 'package:ecommerce/common/widgets/images/t_circular_image.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:ecommerce/features/personalization/screens/profile/widgets/change_number_phone.dart';
import 'package:ecommerce/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:ecommerce/common/widgets/shimmers/shimmer.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../change_password.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.to(() => const NavigationMenu()), // Navigate to SettingsScreen
          icon: Icon(Iconsax.arrow_left, color: dark ? TColors.white : TColors.dark),
        ),
        title: const Text('Profile'),
      ),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// Profile Picture
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Obx((){
                        final networkImage = controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty ? networkImage : TImages.user;
                        return controller.imageUploading.value
                            ? const TShimmerEffect(width: 80, height: 80, radius: 80)
                            : TCircularImage(image: image, width: 80, height: 80, isNetworkImage: networkImage.isNotEmpty);
                      }),
                      TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),
                    ],
                  ),
                ),

                /// Details
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Heading Profile Info
                const TSectionHeading(title: 'Profile Information', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),


                TProfileMenu(title: 'Name', value: controller.user.value.fullName,icon: Iconsax.arrow_right_34, onPressed: () => Get.to(() => const ChangeName())),
                TProfileMenu(title: 'Username', value: controller.user.value.username, onPressed: (){}),

                const SizedBox(height: TSizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Heading Personal Info
                const TSectionHeading(title: 'Personal Information', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),

                TProfileMenu(title: 'User ID', value: controller.user.value.id, icon: Iconsax.copy, onPressed: () {
                  Clipboard.setData(ClipboardData(text: controller.user.value.id));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User ID copied to clipboard')));
                }),
                TProfileMenu(title: 'E-mail', value: controller.user.value.email, onPressed: (){}),
                TProfileMenu(title: 'Phone Number', value: controller.user.value.phoneNumber,icon: Iconsax.arrow_right_34, onPressed: () => Get.to(() => const ChangeNumberPhone())),
                TProfileMenu(title: 'Password', value: '*********',icon: Iconsax.arrow_right_34, onPressed: () => Get.to(() => ChangePasswordScreen())),

                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),

                Center(
                  child: TextButton(
                      onPressed: () => controller.deleteAccountWarningPopup(),
                      child: const Text('Close Account', style: TextStyle(color: Colors.red)),
                  ),
                ),


              ],
            ),
        ),
      ),

    );
  }
}
