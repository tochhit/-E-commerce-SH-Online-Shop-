class TFirebaseException implements Exception {
  final String code;

  TFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use': return 'The email address is already registered. Please use a different email.';
      case 'invalid-email': return 'The email address provided is invalid. Please enter a valid email.';
      default: return 'An unexpected Firebase error occurred. Please try again.';

    }
  }

}