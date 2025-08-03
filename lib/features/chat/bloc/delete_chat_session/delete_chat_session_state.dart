part of 'delete_chat_session_cubit.dart';

class DeleteChatSessionState extends AppBlocBaseState {
  const DeleteChatSessionState({
    super.type = AppBlocBaseStateType.initial,
    super.data,
    super.errorMessage,
  });

  @override
  DeleteChatSessionState copyWith({
    AppBlocBaseStateType? type,
    data,
    String? errorMessage,
  }) {
    return DeleteChatSessionState(
      type: type ?? this.type,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
