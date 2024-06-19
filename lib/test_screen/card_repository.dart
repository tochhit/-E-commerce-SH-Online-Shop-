import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:get/get.dart';

import 'credit_card_model.dart';

class CardRepository extends GetxController {
  static CardRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<CreditCardModel>> fetchUserCards() async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) throw 'Unable to find user information. Try again in few minutes.';

      final result = await _db.collection('Users').doc(userId).collection('Credit Card').get();
      return result.docs.map((documentSnapshot) => CreditCardModel.fromDocumentSnapshot(documentSnapshot)).toList();
    } catch (e) {
      throw 'Something went wrong while fetching Card Information. Try again later';
    }
  }

  Future<void> updateSelectedField(String cardId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;
      await _db.collection('Users').doc(userId).collection('Credit Card').doc(cardId).update({'selectedCard': selected});
    } catch (e) {
      throw 'Unable to update your Card selection. Try again later';
    }
  }

  Future<String> addCard(CreditCardModel card) async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;
      final currentCard = await _db.collection('Users').doc(userId).collection('Credit Card').add(card.toJson());
      return currentCard.id;
    } catch (e) {
      throw 'Something went wrong while saving Card Information. Try again later';
    }
  }
}
