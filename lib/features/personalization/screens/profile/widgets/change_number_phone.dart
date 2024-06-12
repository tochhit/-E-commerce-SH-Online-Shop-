import 'package:flutter/material.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';

class ChangeNumberPhone extends StatelessWidget {
  const ChangeNumberPhone({Key? key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'New Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) => controller.newPhoneNumber.value = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call a method in the UserController to update the phone number
                controller.updatePhoneNumber();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
