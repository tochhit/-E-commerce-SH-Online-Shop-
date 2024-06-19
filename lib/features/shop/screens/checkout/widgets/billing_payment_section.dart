import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/product/checkout_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:ecommerce/common/widgets/products/products_cards/rounded_container.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(() {
      final selectedPaymentMethod = controller.selectedPaymentMethod.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TSectionHeading(
            title: 'Payment Method',
            buttonTitle: 'Change',
            onPressed: () => controller.selectPaymentMethod(context),
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          selectedPaymentMethod != null
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TRoundedContainer(
                    width: 40,
                    child: Image.asset(
                      controller.getImagePathForCardType(selectedPaymentMethod.cardType),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedPaymentMethod.cardHolderName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '**** ${selectedPaymentMethod.cardNumber.substring(selectedPaymentMethod.cardNumber.length - 4)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
              : Text(
            'Select Payment Method',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      );
    });
  }
}
