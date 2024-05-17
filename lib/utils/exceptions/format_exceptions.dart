class TFormatException implements Exception {
  final String message;

  const TFormatException([this.message = 'An unexpected format error occurred. Please check your input.']);

  factory TFormatException.fromMessage(String message) {
    return TFormatException(message);
  }

  String get formattedMessage => message;

  factory TFormatException.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const TFormatException(
            'The email address is already registered. Please use a different email.');
      case 'invalid-email':
        return const TFormatException(
            'The email address provided is invalid. Please enter a valid email.');
      default:
        return const TFormatException();
    }
  }
}