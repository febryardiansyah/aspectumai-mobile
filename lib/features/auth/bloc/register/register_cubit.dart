import 'package:aspectumai/features/auth/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final IAuthRepository _authRepository;

  RegisterCubit(IAuthRepository authRepository)
      : _authRepository = authRepository,
        super(RegisterInitial());

  void register(String fullname, String username, String email, String password) async {
    emit(RegisterLoading());

    try {
      final result = await _authRepository.register(
        fullname,
        username,
        email,
        password,
      );

      emit(RegisterSuccess(result));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
