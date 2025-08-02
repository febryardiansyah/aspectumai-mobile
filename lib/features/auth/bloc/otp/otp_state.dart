part of 'otp_cubit.dart';

sealed class OTPState extends Equatable {
  const OTPState();

  @override
  List<Object> get props => [];
}

final class OTPInitial extends OTPState {}

final class OTPLoading extends OTPState {}

final class OTPSuccess extends OTPState {
  final String message;
  final bool isResend;

  const OTPSuccess(this.message, {this.isResend = false});

  @override
  List<Object> get props => [message, isResend];
}

final class OTPFailure extends OTPState {
  final String error;
  final bool isResend;

  const OTPFailure(this.error, {this.isResend = false});

  @override
  List<Object> get props => [error, isResend];
}
