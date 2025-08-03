import 'package:aspectumai/features/auth/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final IAuthRepository _authRepository;

  ResetPasswordCubit(IAuthRepository authRepository)
      : _authRepository = authRepository,
        super(ResetPasswordInitial());

  void resetPassword(
    String email, 
    String password, 
    String otp,
  ) async {
    emit(ResetPasswordLoading());

    try {
      final result = await _authRepository.resetPassword(
        email,
        password,
        otp,
      );

      emit(ResetPasswordSuccess(result));
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }
}
