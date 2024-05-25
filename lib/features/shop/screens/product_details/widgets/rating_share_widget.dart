import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce/utils/constants/sizes.dart';

class TRatingAndShare extends StatelessWidget {
  final double averageRating;
  final int totalRatings;

  const TRatingAndShare({
    Key? key,
    required this.averageRating,
    required this.totalRatings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Iconsax.star5, color: Colors.amber, size: 24),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: averageRating.toStringAsFixed(1), style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(text: ' ($totalRatings)'),
                ],
              ),
            ),
          ],
        ),
        /// Share Button
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.share, size: TSizes.iconMd),
        )
      ],
    );
  }
}
