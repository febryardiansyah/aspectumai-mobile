part of 'create_chat_session_cubit.dart';

final class CreateChatSessionState extends AppBlocBaseState {
  const CreateChatSessionState({
    super.type,
    super.data,
    super.errorMessage,
  });

  @override
  CreateChatSessionState copyWith({
    AppBlocBaseStateType? type,
    data,
    String? errorMessage,
  }) {
    return CreateChatSessionState(
      type: type ?? this.type,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
