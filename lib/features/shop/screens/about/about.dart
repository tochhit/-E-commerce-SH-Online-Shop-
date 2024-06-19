import 'package:ecommerce/features/shop/screens/about/widgets/about_menu.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Contact Us', style: Theme.of(context).textTheme.headlineSmall)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            ProfileSection(),
            SizedBox(height: TSizes.spaceBtwItems),
            ContactDetailsSection(),
            SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Image(
          height: 120,
          image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        Text(
          'S.H online shop',
          style: Theme.of(context).textTheme.headlineMedium,
          ),
      ],
    );
  }
}


class ContactDetailsSection extends StatelessWidget {
  const ContactDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: dark ? TColors.dark : TColors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: dark ? TColors.darkerGrey : TColors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.phone, size: 40),
              Icon(Icons.email, size: 40),
              Icon(Icons.message, size: 40),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          AboutMenu(title: 'Email: ', value: 'shonlineshop@gmail.com', icon: Iconsax.copy, onPressed: () {
            Clipboard.setData(const ClipboardData(text: 'shonlineshop@gmail.com'));
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Number phone copied to clipboard')));
          }),

          const SizedBox(height: TSizes.spaceBtwItems),
          AboutMenu(title: 'Phone: ', value: '012 345 678', icon: Iconsax.copy, onPressed: () {
            Clipboard.setData(const ClipboardData(text: '012 345 678'));
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Number phone copied to clipboard')));
          }),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Location: ',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const TextSpan(text: 'Street 103, Phnom Penh'),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          Center(
            child: Text(
              'Social Media',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(TImages.facebook2, width: 40, height: 40), // Replace with actual path
              Image.asset(TImages.messenger, width: 40, height: 40), // Replace with actual path
              Image.asset(TImages.tiktok, width: 40, height: 40), // Replace with actual path
              Image.asset(TImages.telegram, width: 40, height: 40), // Replace with actual path
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          Text(
            'Social Contact:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5,0),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'https://sautsreyleak.github.io/My-Social-Contact/',
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      // Launch the URL in a web view or browser
                      launch('https://sautsreyleak.github.io/My-Social-Contact/');
                    },
                  ),
                ],
              ),
            ),
          ),



        ],
      ),
    );
  }
}