enum EmailVerificationType {
  signUp("SIGNUP"),
  forgotPassword("RESET_PASSWORD");

  const EmailVerificationType(this.value);
  final String value;

  static EmailVerificationType fromString(String type) {
    switch (type) {
      case 'SIGNUP':
        return EmailVerificationType.signUp;
      case 'RESET_PASSWORD':
        return EmailVerificationType.forgotPassword;
      default:
        throw ArgumentError('Unknown EmailVerificationType: $type');
    }
  }
}
