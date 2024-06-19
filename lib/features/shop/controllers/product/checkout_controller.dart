import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';

import '../../../../test_screen/card_controller.dart';
import '../../../../test_screen/card_method_item.dart';
import '../../../../test_screen/credit_card_model.dart';
import '../../../../test_screen/payment.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<CreditCardModel?> selectedPaymentMethod = Rx<CreditCardModel?>(null);

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> selectPaymentMethod(BuildContext context) async {
    final cardController = Get.put(CardController());
    final selectedCard = await showModalBottomSheet<CreditCardModel>(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TSectionHeading(title: 'Select Payment Method', showActionButton: false),
              for (var card in cardController.cards)
                GestureDetector(
                  onTap: () {
                    selectedPaymentMethod.value = card;
                    Get.back(); // Close the bottom sheet
                  },
                  child: CardMethodItem(
                    imagePath: getImagePathForCardType(card.cardType),
                    title: card.cardHolderName,
                    description: '*****${card.cardNumber.substring(card.cardNumber.length - 4)}',
                    cardType: card.cardType,
                  ),
                ),
              const SizedBox(height: 16), // Spacer
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close the bottom sheet
                    Get.to(() => const PaymentMethodsScreen()); // Navigate to add new payment method screen
                  },
                  child: const Text('Add New Payment Method'),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (selectedCard != null) {
      // Handle selected card if needed
    }
  }

  String getImagePathForCardType(CardType cardType) {
    switch (cardType) {
      case CardType.visa:
        return TImages.visa1;
      case CardType.mastercard:
        return TImages.master1;
    // Add cases for other card types as needed
      default:
        return ''; // Default image path or handle unknown cases
    }
  }
}

