import 'package:ecommerce/common/widgets/products/products_cards/rounded_container.dart';
import 'package:ecommerce/features/shop/controllers/product/checkout_controller.dart';
import 'package:ecommerce/test_screen/credit_card_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TPaymentTile extends StatelessWidget {
  const TPaymentTile({super.key, required this.paymentMethod});

  final CreditCardModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: TRoundedContainer(
        width: 40,
        height: 40,
        backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.light : TColors.white,
        padding: const EdgeInsets.all(TSizes.sm),
        child: Image(image: AssetImage(getImagePathForCardType(paymentMethod.cardType)), fit: BoxFit.contain),
      ),
      title: Text(paymentMethod.cardHolderName),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }

  String getImagePathForCardType(CardType cardType) {
    // Replace with your implementation to get the image path for each card type
    switch (cardType) {
      case CardType.visa:
        return TImages.visa1; // Example path
      case CardType.mastercard:
        return TImages.master1;
      case CardType.amex:
        return TImages.amex;
      case CardType.unionpay:
        return TImages.unionpay;
      default:
        return ''; // Default image path or handle unknown cases
    }
  }
}
