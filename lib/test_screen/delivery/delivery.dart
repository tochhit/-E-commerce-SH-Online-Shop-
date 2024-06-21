import 'package:ecommerce/test_screen/delivery/packages.dart';
import 'package:ecommerce/test_screen/delivery/review_order.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/appbar/appbar.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Delivery', style: Theme.of(context).textTheme.headlineSmall)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            DeliveryCard(
              deliveryDate: '18/June/24',
              orderId: '[ WEs795 ]',
              status: 'Delivery to Customer',
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            DeliveryCard(
              deliveryDate: '20/June/24',
              orderId: '[ sEg579 ]',
              status: 'Delivery on the way',
            ),
          ],
        ),
      ),
    );
  }
}

class DeliveryCard extends StatelessWidget {
  final String deliveryDate;
  final String orderId;
  final String status;

  const DeliveryCard({
    Key? key,
    required this.deliveryDate,
    required this.orderId,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Card(
      color: dark ? TColors.darkerGrey : TColors.light,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_shipping, size: 30),
                const SizedBox(width: 10),
                Text(
                  'Delivery: $deliveryDate',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: TSizes.defaultSpace),
            Text(
              'OrderID: $orderId',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.borderRadiusLg),
            Row(
              children: [
                const Icon(Icons.circle, color: Colors.blue, size: 15),
                const SizedBox(width: 5),
                Text(status, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: TSizes.borderRadiusMd),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Get.to(()=> const ReviewOrderScreen()),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Optional: custom button shape
                    ),
                    backgroundColor: dark ? TColors.dark : TColors.grey, // Example background color
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 110,
                    child: Center(
                      child: Text(
                        'Review Order',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                ElevatedButton(
                  onPressed: () => Get.to(()=> const PackagesScreen()),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Optional: custom button shape
                    ),
                    backgroundColor: dark ? TColors.dark : TColors.grey, // Example background color
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 60,
                    child: Center(
                      child: Text(
                        'Check',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}