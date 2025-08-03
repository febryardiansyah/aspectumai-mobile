part of '../chat_screen.dart';

class _ChatInput extends StatelessWidget {
  final chatEdc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        left: 20,
      ),
      height: kBottomNavigationBarHeight,
      child: AppTextForm(
        hint: 'Ask anything..',
        prefixIcon:
            const Icon(Icons.add_photo_alternate, color: AppColors.white),
        suffixIcon: GestureDetector(
          onTap: () {
            context.read<ChatBloc>().add(
                  StartChatEvent(
                    message: ChatMessageModel(
                      content: chatEdc.text,
                      role: 'user',
                    ),
                  ),
                );
            chatEdc.clear();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: const Icon(Icons.send, color: AppColors.white),
        ),
        controller: chatEdc,
      ),
    );
  }
}
