// credit_card_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

enum CardType {
  visa,
  mastercard,
  amex,
  unionpay,
  invalid,
}

class CreditCardModel {
  String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final CardType cardType;
  bool selectedCard;

  CreditCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    required this.cardType,
    this.selectedCard = true,
  });

  static CreditCardModel empty() => CreditCardModel(
    id: '',
    cardNumber: '',
    cardHolderName: '',
    expiryDate: '',
    cvv: '',
    cardType: CardType.invalid,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'cardType': cardType.toString().split('.').last, // Store enum as string
      'selectedCard': selectedCard,
    };
  }

  factory CreditCardModel.fromMap(Map<String, dynamic> data) {
    return CreditCardModel(
      id: data['id'] as String,
      cardNumber: data['cardNumber'] as String,
      cardHolderName: data['cardHolderName'] as String,
      expiryDate: data['expiryDate'] as String,
      cvv: data['cvv'] as String,
      cardType: _cardTypeFromString(data['cardType'] as String),
      selectedCard: data['selectedCard'] as bool,
    );
  }

  factory CreditCardModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CreditCardModel(
      id: snapshot.id,
      cardNumber: data['cardNumber'] ?? '',
      cardHolderName: data['cardHolderName'] ?? '',
      expiryDate: data['expiryDate'] ?? '',
      cvv: data['cvv'] ?? '',
      cardType: _cardTypeFromString(data['cardType'] ?? ''),
      selectedCard: data['selectedCard'] as bool,
    );
  }

  static CardType _cardTypeFromString(String value) {
    switch (value.toLowerCase()) {
      case 'visa':
        return CardType.visa;
      case 'mastercard':
        return CardType.mastercard;
      case 'amex':
        return CardType.amex;
      case 'unionpay':
        return CardType.unionpay;
      default:
        return CardType.invalid;
    }
  }

  @override
  String toString() {
    return '$cardNumber, $cardHolderName, $expiryDate, $cvv, $cardType';
  }
}
