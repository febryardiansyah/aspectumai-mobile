import 'package:aspectumai/dependency_injection.dart';
import 'package:aspectumai/features/chat/bloc/chat/chat_bloc.dart';
import 'package:aspectumai/features/chat/bloc/delete_chat_session/delete_chat_session_cubit.dart';
import 'package:aspectumai/features/chat/models/chat_response_model.dart';
import 'package:flutter/material.dart';
import 'package:aspectumai/core/resources/illustrations.dart';
import 'package:aspectumai/core/resources/colors.dart';
import 'package:aspectumai/core/utils/extensions/context_ext.dart';
import 'package:aspectumai/core/widgets/app_spacer.dart';
import 'package:aspectumai/core/widgets/app_text_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

part 'widgets/chat_response.dart';
part 'widgets/chat_input.dart';
part 'widgets/custom_appbar.dart';

class ChatScreen extends StatelessWidget {
  final bool isCustomChat;
  const ChatScreen({super.key, this.isCustomChat = false});

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ChatBloc(sl()),
        ),
        BlocProvider(
          create: (_) => DeleteChatSessionCubit(sl()),
        ),
      ],
      child: PopScope(
        onPopInvoked: (value){
          context.read<DeleteChatSessionCubit>().deleteChatSession(5);
        },
        child: Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: bottomInsets),
            child: _ChatInput(),
          ),
          // floatingActionButton:
          //     bottomInsets < 1 ? const _SuggestionStarters() : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          appBar: appBar,
          body: _ChatBody(isCustomChat: isCustomChat),
        ),
      ),
    );
  }

  PreferredSizeWidget get appBar {
    return isCustomChat
        ? const _CustomChatAppbar() as PreferredSizeWidget
        : const _DefaultAppBar() as PreferredSizeWidget;
  }
}

class _ChatBody extends StatelessWidget {
  final bool isCustomChat;
  const _ChatBody({required this.isCustomChat});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, List<ChatMessageModel>>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: Column(
            children: state.map((e) {
              if (e.role == 'assistant') {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _AssistantMessage(text: e.content ?? ''),
                );
              } else if (e.role == 'user') {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _UserMessage(text: e.content ?? ''),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }).toList(),
          ),
        );
      },
    );
  }
}

class _SuggestionStarters extends StatelessWidget {
  const _SuggestionStarters();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        children: List.generate(2, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                // context.read<ChatBloc>().add(
                //     StartChatEvent(message: ChatMessageEntity(content: '')));
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: index == 0 ? 10 : 0,
                  left: index == 1 ? 10 : 0,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.secondary),
                  color: AppColors.primary,
                ),
                child: const Text(
                  'What Can you do?',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
