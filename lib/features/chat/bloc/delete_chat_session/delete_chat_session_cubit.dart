import 'package:aspectumai/core/bloc/app_bloc_base_state.dart';
import 'package:aspectumai/features/chat/repositories/chat_repository.dart';
import 'package:bloc/bloc.dart';

part 'delete_chat_session_state.dart';

class DeleteChatSessionCubit extends Cubit<DeleteChatSessionState> {
  DeleteChatSessionCubit(this._repo) : super(const DeleteChatSessionState());
  final ChatRepository _repo;

  void deleteChatSession(int sessionId) async {
    emit(state.copyWith(type: AppBlocBaseStateType.loading));

    try {
      await _repo.deleteChatSession(sessionId);

      emit(state.copyWith(type: AppBlocBaseStateType.success));
    } catch (e) {
      emit(state.copyWith(
        type: AppBlocBaseStateType.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
