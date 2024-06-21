import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';

class ReviewOrderScreen extends StatelessWidget {
  const ReviewOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Order'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'OrderID: [WEs795]',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'Day: 18/june/24',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: TSizes.defaultSpace),
            Expanded(
              child: ListView(
                children: const [
                  ReviewOrderItem(
                    image: TImages.productImage1, // Replace with actual image URL
                    itemName: 'T-Shirt Black',
                    quantity: 2,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  ReviewOrderItem(
                    image: TImages.productImage2, // Replace with actual image URL
                    itemName: 'Nice Shoe',
                    quantity: 1,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  ReviewOrderItem(
                    image: TImages.productImage4, // Replace with actual image URL
                    itemName: 'Vans Red',
                    quantity: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewOrderItem extends StatelessWidget {
  final String image;
  final String itemName;
  final int quantity;

  const ReviewOrderItem({
    Key? key,
    required this.image,
    required this.itemName,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: AssetImage(image), // Use AssetImage for local assets
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              itemName,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              'Quantity: $quantity',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
