import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'credit_card_model.dart';

class CardController extends GetxController {
  RxList<CreditCardModel> cards = <CreditCardModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCards();
  }

  Future<void> fetchCards() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('cards').get();
      cards.assignAll(snapshot.docs.map((doc) => CreditCardModel.fromDocumentSnapshot(doc)).toList());
    } catch (e) {
      print('Error fetching cards: $e');
    }
  }

  Future<void> addCard(CreditCardModel newCard) async {
    try {
      await FirebaseFirestore.instance.collection('cards').add(newCard.toJson());
      cards.add(newCard);
    } catch (e) {
      print('Error adding card: $e');
    }
  }

  Future<void> deleteCard(CreditCardModel card) async {
    try {
      await FirebaseFirestore.instance.collection('cards').doc(card.id).delete();
      cards.removeWhere((c) => c.id == card.id);
    } catch (e) {
      print('Error deleting card: $e');
    }
  }

  // Updated method to delete the first card found by type
  Future<void> deleteCardByType(CardType cardType) async {
    try {
      // Find the first card matching the cardType
      CreditCardModel? cardToDelete = cards.firstWhereOrNull((card) => card.cardType == cardType);
      if (cardToDelete != null) {
        // Delete card from Firestore
        await FirebaseFirestore.instance.collection('cards').doc(cardToDelete.id).delete();

        // Remove card from local list
        cards.remove(cardToDelete);
      } else {
        print('No card found of type $cardType to delete.');
      }
    } catch (e) {
      print('Error deleting card by type: $e');
    }
  }
  bool _isAcceptedCardType(CardType cardType) {
    switch (cardType) {
      case CardType.visa:
      case CardType.mastercard:
      case CardType.unionpay:
      case CardType.amex:
        return true;
      default:
        return false;
    }
  }

}
