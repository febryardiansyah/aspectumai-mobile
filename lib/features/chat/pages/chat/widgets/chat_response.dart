part of '../chat_screen.dart';

class _AssistantMessage extends StatelessWidget {
  final String text;
  const _AssistantMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
          const AppSpacer.width(6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Markdown(data: text, shrinkWrap: true),
                Text(text),
                const AppSpacer.height(8),
                const Icon(Icons.copy, color: AppColors.grey, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserMessage extends StatelessWidget {
  final String text;
  const _UserMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: context.screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 18,
              ),
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                  // const AppSpacer.height(10),
                  // Container(
                  //   width: context.screenWidth * 0.7,
                  //   height: 200,
                  //   decoration: BoxDecoration(
                  //     color: AppColors.grey,
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  // ),
                ],
              ),
            ),
            const AppSpacer.width(6),
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
