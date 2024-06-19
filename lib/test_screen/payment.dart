// payment_methods_screen.dart

import 'package:ecommerce/test_screen/test_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/widgets/appbar/appbar.dart';
import '../common/widgets/texts/section_heading.dart';
import '../utils/constants/image_strings.dart';
import '../utils/constants/sizes.dart';
import 'add_credit_card.dart';
import 'card_controller.dart';
import 'card_method_item.dart';
import 'payment_method_item.dart';
import 'credit_card_model.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardController = Get.put(CardController());

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Payment Methods',
          style: Theme
              .of(context)
              .textTheme
              .titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
              () =>
              ListView(
                children: [
                  const TSectionHeading(
                    title: 'Linked Accounts',
                    showActionButton: false,
                  ),
                  for (var card in cardController.cards)
                    CardMethodItem(
                      imagePath: getImagePathForCardType(card.cardType),
                      title: card.cardHolderName,
                      description:
                      '*****${card.cardNumber.substring(
                          card.cardNumber.length - 4)}',
                      cardType: card.cardType, // Pass cardType here
                    ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(
                    title: 'Bank or Mobile Wallet',
                    showActionButton: false,
                  ),
                  const PaymentMethodItem(
                    imagePath: TImages.abaPay,
                    title: 'ABA PAY',
                    description: 'Tap to pay with ABA Mobile',
                  ),
                  const PaymentMethodItem(
                    imagePath: TImages.aceleda,
                    title: 'ACLEDA Bank',
                    description: 'Tap to pay with ACLEDA Bank',
                  ),
                  const PaymentMethodItem(
                    imagePath: TImages.trueMoney,
                    title: 'TrueMoney',
                    description: 'Pay Securely with TrueMoney',
                  ),
                  const PaymentMethodItem(
                    imagePath: TImages.wing,
                    title: 'Wing',
                    description: 'Tap to pay with Wing Bank',
                  ),
                  const PaymentMethodItem(
                    imagePath: TImages.amk,
                    title: 'AMK CLICK PAY',
                    description: 'Tap to pay with AMK Mobile',
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(
                    title: 'Credit Card',
                    showActionButton: false,
                  ),
                  CPaymentMethodItem(
                    imagePath: TImages.creditCard,
                    title: 'Credit/Debit Card',
                    logoPaths: const [
                      TImages.visa1,
                      TImages.master1,
                      TImages.unionpay,
                    ],
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddNewCardScreen(),
                        ),
                      );
                    },
                  ),

                ],
              ),
        ),
      ),
    );
  }
}

  String getImagePathForCardType(CardType cardType) {
    switch (cardType) {
      case CardType.visa:
        return TImages.visa1;
      case CardType.mastercard:
        return TImages.master1;
      case CardType.amex:
        return TImages.amex;
      case CardType.unionpay:
        return TImages.unionpay;
      default:
        return ''; // Handle default case if necessary
    }
  }
