import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/constants/image_strings.dart';
import 'card_input_formatter.dart';
import 'card_controller.dart';
import 'credit_card_model.dart';

class AddNewCardScreen extends StatefulWidget {
  final Function(CreditCardModel)? onCreditCardAdded;

  const AddNewCardScreen({Key? key, this.onCreditCardAdded}) : super(key: key);

  @override
  _AddNewCardScreenState createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();

  CardType cardType = CardType.invalid;

  @override
  void initState() {
    super.initState();
    cardNumberController.addListener(() {
      getCardTypeFromNumber();
    });
  }

  void getCardTypeFromNumber() {
    String cardNum = CardUtils.getCleanedNumber(cardNumberController.text);
    CardType type = CardUtils.getCardTypeFromNumber(cardNum);
    if (type != cardType) {
      setState(() {
        cardType = type;
      });
    }
  }

  void addCard() {
    // Check if card type is one of the accepted types
    if (!isCardTypeAccepted(cardType)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Invalid Card Type"),
            content: const Text("Only Visa, MasterCard, UnionPay, and Amex cards are accepted."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return; // Exit addCard method if card type is not accepted
    }

    CreditCardModel newCard = CreditCardModel(
      cardNumber: cardNumberController.text,
      cardHolderName: cardHolderNameController.text,
      expiryDate: expiryDateController.text,
      cvv: cvvController.text,
      cardType: cardType,
      id: '', // Empty ID, to be assigned by Firestore or similar
    );

    if (widget.onCreditCardAdded != null) {
      widget.onCreditCardAdded!(newCard);
    }

    Get.find<CardController>().addCard(newCard); // Using GetX for state management

    Navigator.of(context).pop();
  }

  bool isCardTypeAccepted(CardType type) {
    return type == CardType.visa ||
        type == CardType.mastercard ||
        type == CardType.unionpay ||
        type == CardType.amex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: cardNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(19),
                      CardNumberInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Card number',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CardUtils.getCardIcon(cardType),
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Icon(Icons.credit_card),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card number';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      controller: cardHolderNameController,
                      decoration: const InputDecoration(
                        hintText: 'Full Name',
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Icon(Icons.person),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter full name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cvvController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          decoration: const InputDecoration(
                            hintText: 'CVV',
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Icon(Icons.hide_image),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter CVV';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: TextFormField(
                          controller: expiryDateController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            CardMonthInputFormatter(),
                          ],
                          decoration: const InputDecoration(
                            hintText: 'MM/YY',
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Icon(Icons.date_range),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter expiry date';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addCard,
                child: const Text('Add Card'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardUtils {
  static String getCleanedNumber(String cardNumber) {
    return cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
  }

  static CardType getCardTypeFromNumber(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      return CardType.visa;
    } else if (cardNumber.startsWith('5')) {
      return CardType.mastercard;
    } else if (cardNumber.startsWith('34') || cardNumber.startsWith('37')) {
      return CardType.amex;
    } else if (cardNumber.startsWith('6')) {
      return CardType.unionpay;
    } else {
      return CardType.invalid;
    }
  }

  static Widget getCardIcon(CardType cardType) {
    switch (cardType) {
      case CardType.visa:
        return Image.asset(TImages.visa1, width: 30, height: 30);
      case CardType.mastercard:
        return Image.asset(TImages.master1, width: 30, height: 30);
      case CardType.amex:
        return Image.asset(TImages.amex, width: 30, height: 30);
      case CardType.unionpay:
        return Image.asset(TImages.unionpay, width: 30, height: 30);
      default:
        return const SizedBox();
    }
  }
}
