import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../personalization/screens/profile/profile.dart';

class ChangePasswordController extends GetxController {
  static ChangePasswordController get instance => Get.find();

  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  void changePassword() async {
    try {
      TFullScreenLoader.openLoadingDialog('Changing Password...', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!changePasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Check if newPassword matches confirmPassword
      if (newPassword.text.trim() != confirmPassword.text.trim()) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: 'Password Mismatch',
          message: 'New Password and Confirm Password do not match.',
        );
        return;
      }

      // Re-authenticate user before changing password
      await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(
        AuthenticationRepository.instance.authUser.email!,
        currentPassword.text.trim(),
      );

      // Change Password
      await AuthenticationRepository.instance.changePassword(newPassword.text.trim());

      // Password Changed Successfully
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Password Changed',
        message: 'Your password has been successfully changed.',
      );

      // Clear fields
      currentPassword.clear();
      newPassword.clear();
      confirmPassword.clear();

      // Navigate to ProfileScreen
      Get.to(() => const ProfileScreen());

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Failed to Change Password',
        message: e.toString(),
      );
    }
  }

  @override
  void onClose() {
    // Clean up controllers when the controller is closed
    currentPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}
