import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'card_controller.dart';
import 'credit_card_model.dart';

class SingleCard extends StatelessWidget {
  final CreditCardModel card;
  final VoidCallback onDelete;

  const SingleCard({
    Key? key,
    required this.card,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement card selection logic if needed
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Image.asset(
            getCardImage(), // Use your logic to get the card image path
            width: 40,
          ),
          title: Text(
            'Card ending ****${card.cardNumber.substring(card.cardNumber.length - 4)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('${card.cardHolderName} \nExpires: ${card.expiryDate}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Call delete method from CardController
              Get.find<CardController>().deleteCard(card);
              onDelete();
            },
          ),
        ),
      ),
    );
  }

  String getCardImage() {
    // Replace with your logic to determine the card image based on card type
    // Example logic:
    switch (card.cardType) {
      case CardType.visa:
        return 'assets/images/visa.png';
      case CardType.mastercard:
        return 'assets/images/mastercard.png';
      case CardType.amex:
        return 'assets/images/amex.png';
      case CardType.unionpay:
        return 'assets/images/unionpay.png';
      default:
        return 'assets/images/default_card.png';
    }
  }
}
