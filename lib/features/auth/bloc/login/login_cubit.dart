import 'package:aspectumai/features/auth/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final IAuthRepository _authRepository;

  LoginCubit(IAuthRepository authRepository)
      : _authRepository = authRepository,
        super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());

    try {
      final result = await _authRepository.login(
        email,
        password,
      );

      emit(LoginSuccess(token: result.token!));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
