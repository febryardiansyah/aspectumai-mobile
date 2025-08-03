part of '../chat_screen.dart';

class _DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _DefaultAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      iconTheme: const IconThemeData(color: AppColors.white),
      elevation: 0,
      shadowColor: Colors.transparent,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.red,
            ),
          ),
          const AppSpacer.width(14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Math Solver',
                    style: TextStyle(fontSize: 16, color: AppColors.white),
                  ),
                  const AppSpacer.width(8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(IllustrationConstants.coin,
                            width: 10, height: 10),
                        const AppSpacer.width(4),
                        const Text(
                          '1',
                          style:
                              TextStyle(fontSize: 10, color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'See details',
                    style: TextStyle(fontSize: 10, color: AppColors.grey),
                  ),
                  AppSpacer.width(4),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.grey,
                    size: 10,
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          const Icon(Icons.bookmark_outline, color: AppColors.white),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.secondary,
          height: 1.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomChatAppbar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomChatAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      iconTheme: const IconThemeData(color: AppColors.white),
      elevation: 0,
      shadowColor: Colors.transparent,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.red,
            ),
          ),
          const AppSpacer.width(14),
          Row(
            children: [
              const Text(
                'Math Solver',
                style: TextStyle(fontSize: 16, color: AppColors.white),
              ),
              const AppSpacer.width(8),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(IllustrationConstants.coin,
                        width: 10, height: 10),
                    const AppSpacer.width(4),
                    const Text(
                      '1',
                      style:
                          TextStyle(fontSize: 10, color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.bookmark_outline, color: AppColors.white),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.secondary,
          height: 1.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
