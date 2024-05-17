import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/sizes.dart';

class LogoutController extends GetxController {
  static LogoutController get instance => Get.find();

  Future<void> logout() async {
    final confirmed = await Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Logout Confirmation',
      middleText: 'Are you sure you want to logout?',
      confirm: ElevatedButton(
        onPressed: () => Get.back(result: true),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: const Padding(padding: EdgeInsets.symmetric(horizontal: TSizes.lg), child: Text('Logout')),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(result: false),
        child: const Text('Cancel'),
      ),
    );

    if (confirmed != null && confirmed) {
      try {
        TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);
        await AuthenticationRepository.instance.logout();
      } catch (e) {
        TFullScreenLoader.stopLoading();
        // Handle logout error
      }
    }
  }
}
