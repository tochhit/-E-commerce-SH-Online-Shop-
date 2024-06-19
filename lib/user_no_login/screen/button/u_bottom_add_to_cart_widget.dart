import 'package:ecommerce/common/widgets/icons/t_circular_icon.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/user_no_login/screen/screen/u_login.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UBottomAddToCart extends StatefulWidget {
  const UBottomAddToCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  _UBottomAddToCartState createState() => _UBottomAddToCartState();
}

class _UBottomAddToCartState extends State<UBottomAddToCart> {
  int productQuantity = 0;



  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: TColors.darkGrey,
                width: 40,
                height: 40,
                color: TColors.white,
                onPressed: () {
                  setState(() {
                    if (productQuantity > 0) {
                      productQuantity -= 1;
                      if (productQuantity == 0) {
                        (widget.product);
                      }
                    }
                  });
                },
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(productQuantity.toString(), style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: TSizes.spaceBtwItems),
              TCircularIcon(
                icon: Iconsax.add,
                backgroundColor: TColors.black,
                width: 40,
                height: 40,
                color: TColors.white,
                onPressed: () {
                  setState(() {
                    productQuantity += 1;
                  });
                },
              ),
            ],
          ),
          if (productQuantity > 0)
            ElevatedButton(
              onPressed: () => Get.to(const ULoginScreen()),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: TColors.black,
                side: const BorderSide(color: TColors.black),
              ),
              child: const Text('Add to Cart'),
            ),
        ],
      ),
    );
  }
}
