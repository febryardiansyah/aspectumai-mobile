part of 'email_verification_cubit.dart';

final class EmailVerificationState extends AppBlocBaseState {
  const EmailVerificationState({
    super.type,
    super.data,
    super.errorMessage,
  });

  @override
  EmailVerificationState copyWith({
    AppBlocBaseStateType? type,
    data,
    String? errorMessage,
  }) {
    return EmailVerificationState(
      type: type ?? this.type,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
