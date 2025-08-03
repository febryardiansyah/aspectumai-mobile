import 'package:aspectumai/core/bloc/app_bloc_base_state.dart';
import 'package:aspectumai/features/auth/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';

import '../../utils/auth_utils.dart';

part 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  EmailVerificationCubit(this._authRepository)
      : super(const EmailVerificationState());
  final IAuthRepository _authRepository;

  Future<void> sendEmailVerification({
    required String email,
    required EmailVerificationType type,
  }) async {
    try {
      emit(const EmailVerificationState(type: AppBlocBaseStateType.loading));

      final message = await _authRepository.emailVerification(
        email: email,
        type: type,
      );
      emit(EmailVerificationState(
        type: AppBlocBaseStateType.success,
        data: message,
      ));
    } catch (error) {
      emit(EmailVerificationState(
        type: AppBlocBaseStateType.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
