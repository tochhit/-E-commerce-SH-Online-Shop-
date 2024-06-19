import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/icons/t_circular_icon.dart';
import 'package:ecommerce/common/widgets/loaders/animation_loader.dart';
import 'package:ecommerce/user_no_login/screen/screen/u_login.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UFavouriteScreen extends StatelessWidget {
  const UFavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(icon: Iconsax.add, onPressed: () => Get.to(const ULoginScreen())),
        ],
      ),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: TAnimationLoaderWidget(
            text: 'Whoops! Wishlist is Empty...',
            animation: TImages.successfullyRegisterAnimation,
            showAction: true,
            actionText: 'Let\'s add some',
            onActionPressed: () => Get.to(() => const ULoginScreen()),
          ),
        ),
      ),
    );
  }
}
