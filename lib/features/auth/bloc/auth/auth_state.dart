part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthenticatedState extends AuthState {}
final class UnAuthenticatedState extends AuthState {}
