import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/authenticantion/controllers/forget_password/change_password/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  final ChangePasswordController controller = Get.put(ChangePasswordController());

  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.changePasswordFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: controller.currentPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: controller.newPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: controller.confirmPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password.';
                  }
                  if (value != controller.newPassword.text) {
                    return 'Passwords do not match.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.changePassword(),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
