import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/t_circular_image.dart';
import '../shimmers/shimmer.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Obx(() {
      final networkImage = controller.user.value.profilePicture;
      final image = networkImage.isNotEmpty ? networkImage : TImages.user;
      return ListTile(
        leading: controller.imageUploading.value
            ? const TShimmerEffect(width: 50, height: 50, radius: 50)
            : TCircularImage(image: image, width: 50, height: 50, isNetworkImage: networkImage.isNotEmpty),
        title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),),
        subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),),
        trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: TColors.white),),
      );
    });
  }
}
