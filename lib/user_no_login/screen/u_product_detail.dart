import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:ecommerce/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:ecommerce/user_no_login/screen/products_cards/u_product_detail_image_slider.dart';
import 'package:ecommerce/user_no_login/screen/screen/u_login.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'button/u_bottom_add_to_cart_widget.dart';


class UProductDetailScreen extends StatelessWidget {
  const UProductDetailScreen({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: UBottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1 - Product Image Slider
            UProductImageSlider(product: product),

            /// 2 - Product Details
            Padding(
              padding: const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  /// - Ratting & Share Button
                  TRatingAndShare(averageRating: product.averageRating, totalRatings: product.totalRatings),

                  /// - Price, Title, Stock, & Brand
                  TProductMetaData(product: product),

                  /// - Attributes
                  if (product.productType == ProductType.variable.toString()) TProductAttributes(product: product),
                  if (product.productType == ProductType.variable.toString()) const SizedBox(height: TSizes.spaceBtwSections),

                  /// - Checkout Button
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => const ULoginScreen()), child: const Text('Checkout'))),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// - Description
                  const TSectionHeading(title: 'Description', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: TColors.primary),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: TColors.primary),
                  ),

                  /// - Reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(title: 'Reviews(199)', showActionButton: false),
                      IconButton(
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                        onPressed: () => Get.to(() => const ProductReviewScreen()),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections / 2),
                  /// - Product Rating
                  // const TSectionHeading(title: 'Rate this product', showActionButton: false),
                  // const SizedBox(height: TSizes.spaceBtwItems),
                  // ProductRatingBar(
                  //   initialRating: product.userRating,
                  //   onRatingChanged: (rating) { // Ignore the review comment
                  //     // Handle rating change here
                  //   },
                  // ),
                  //const SizedBox(height: TSizes.spaceBtwSections),
                  const UserReviewCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



