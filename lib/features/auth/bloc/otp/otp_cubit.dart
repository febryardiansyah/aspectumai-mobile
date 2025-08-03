import 'package:aspectumai/features/auth/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_state.dart';

class OTPCubit extends Cubit<OTPState> {
  final IAuthRepository _authRepository;

  OTPCubit(IAuthRepository authRepository)
      : _authRepository = authRepository,
        super(OTPInitial());

  void verifyOTP(
      String email, String otp) async {
    emit(OTPLoading());

    try {
      final result = await _authRepository.verifyOTP(
        email,
        otp,
      );

      emit(OTPSuccess(result));
    } catch (e) {
      emit(OTPFailure(e.toString()));
    }
  }

  void resendOTP(String email) async {
    emit(OTPLoading());

    try {
      final result = await _authRepository.resendOTP(
        email,
      );

      emit(OTPSuccess(result, isResend: true));
    } catch (e) {
      emit(OTPFailure(e.toString(), isResend: true));
    }
  }
}
