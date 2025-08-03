import 'package:aspectumai/core/bloc/app_bloc_base_state.dart';
import 'package:aspectumai/features/chat/repositories/chat_repository.dart';
import 'package:bloc/bloc.dart';

part 'create_chat_session_state.dart';

class CreateChatSessionCubit extends Cubit<CreateChatSessionState> {
  CreateChatSessionCubit(this._chatRepository)
      : super(const CreateChatSessionState());
  final IChatRepository _chatRepository;

  Future<void> createChatSession() async {
    emit(state.copyWith(
      type: AppBlocBaseStateType.loading,
    ));
    try {
      await _chatRepository.createChatSession();
      emit(state.copyWith(type: AppBlocBaseStateType.success, data: 'Chat session created'));
    } catch (e) {
      emit(state.copyWith(type: AppBlocBaseStateType.error, errorMessage: e.toString()));
    }
  }
}
