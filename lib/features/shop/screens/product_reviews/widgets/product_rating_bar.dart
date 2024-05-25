import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ecommerce/utils/constants/colors.dart';

class ProductRatingBar extends StatelessWidget {
  final double initialRating;
  final Function(double) onRatingChanged;

  const ProductRatingBar({
    super.key,
    required this.initialRating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 24,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: TColors.primary,
      ),
      onRatingUpdate: onRatingChanged,
    );
  }
}
