import 'package:aspectumai/core/resources/colors.dart';
import 'package:aspectumai/features/chat/pages/history_chat/history_chat_screen.dart';
import 'package:aspectumai/features/home/page/home_screen.dart';
import 'package:aspectumai/features/profile/presentation/page/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentScreen = 0;

  final screens = [
    const HomeScreen(),
    const HistoryChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primary,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.grey.withOpacity(0.7),
        currentIndex: currentScreen,
        onTap: (index) {
          setState(() {
            currentScreen = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: IndexedStack(
        index: currentScreen,
        children: screens,
      ),
    );
  }
}
