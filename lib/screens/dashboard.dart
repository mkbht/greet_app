import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greet_app/controllers/main_menu_controller.dart';
import 'package:greet_app/screens/chat_list.dart';
import 'package:greet_app/screens/chatroom_list.dart';
import 'package:greet_app/screens/discover.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainMenuController mainMenuController = Get.find<MainMenuController>();

    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: mainMenuController.selectedIndex.value,
          items: mainMenuController.menu,
          onTap: mainMenuController.onTap,
        ),
        body: SafeArea(
          child: IndexedStack(
            index: mainMenuController.selectedIndex.value,
            children: const [
              ChatListScreen(),
              ChatroomListScreen(),
              DiscoverScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
