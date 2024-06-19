import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../user_no_login/navigation_menu.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/login/login_controller.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image(
              height: 150,
              image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => Get.offAll(const UNavigationMenu()),
                tooltip: 'Skip',
              ),
            ),
          ],
        ),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: TSizes.sm),
        Text(
          TTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
