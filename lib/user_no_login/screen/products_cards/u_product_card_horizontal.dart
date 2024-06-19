import 'package:ecommerce/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce/common/widgets/products/products_cards/rounded_container.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:ecommerce/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../screen/u_login.dart';
import '../u_product_detail.dart';

class UProductCardHorizontal extends StatelessWidget {
  const UProductCardHorizontal ({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);


    /// Container with side paddings
    return GestureDetector(
      onTap: () => Get.to(() => UProductDetailScreen(product: product)),
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.softGrey,
        ),
        child: Row(
          children: [
            /// Thumbnail
            TRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  /// -- Thumbnail Image
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: TRoundedImage(imageUrl: product.thumbnail, applyImageRadius: true, isNetworkImage: true),
                  ),

                  /// -- Sale Tag
                  if(salePercentage != null)
                    Positioned(
                      top: 12,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text('$salePercentage%', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black)),
                      ),
                    ),

                  /// -- Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: THelperFunctions.isDarkMode(context)
                            ? TColors.black.withOpacity(0.3)
                            : TColors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(onPressed: () => Get.to(const ULoginScreen()), icon: const Icon(Iconsax.heart5)),
                    ),
                  ),
                ],
              ),
            ),

            /// Details
            SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TProductTitleText(title: product.title, smallSize: true),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),
                        TBrandTitleWithVerifiedIcon(title: product.brand!.name),
                      ],
                    ),

                    const Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Price
                        Flexible(
                          child: Column(
                            children: [
                              if (product.productType == ProductType.single.toString() && product.salePrice > 0)
                                Padding(
                                  padding: const EdgeInsets.only(left: TSizes.sm),
                                  child: Text(
                                    product.price.toString(),
                                    style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                                  ),
                                ),

                              /// Price, Show sale price as main price if sale exist.
                              Padding(
                                padding: const EdgeInsets.only(left: TSizes.sm),
                                child: TProductPriceText(price: controller.getProductPrice(product)),
                              ),
                            ],
                          ),
                        ),

                        /// Add to Cart Button
                        Container(
                          decoration: const BoxDecoration(
                            color: TColors.dark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(TSizes.cardRadiusMd),
                              bottomRight: Radius.circular(TSizes.productImageRadius),
                            ),
                          ),
                          child: SizedBox(
                            width: TSizes.iconLg * 1.2,
                            height: TSizes.iconLg * 1.2,
                            child: IconButton(onPressed: () => Get.to(const ULoginScreen()), icon: const Icon(Iconsax.add, color: TColors.white)),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}