import 'package:badges/badges.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:greet_app/controllers/privatechat_controller.dart';
import 'package:greet_app/controllers/profile_controller.dart';
import 'package:greet_app/screens/chats/chat_list.dart';
import 'package:greet_app/screens/chats/friend_list.dart';

class ChatPageScreen extends StatelessWidget {
  const ChatPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PrivatechatController privatechatController =
        Get.find<PrivatechatController>();
    ProfileController profileController = Get.find<ProfileController>();
    profileController.fetchMyProfile();

    return Obx(
      () => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Greet"),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Get.toNamed('/search');
                },
              ),
            ],
            leading: InkWell(
              onTap: () {
                Get.toNamed("/myprofile");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20.0,
                  foregroundImage: profileController.user.value.avatar != null
                      ? NetworkImage(profileController.user.value.avatar!)
                      : null,
                  backgroundImage: AssetImage('assets/images/user.jpg'),
                ),
              ),
            ),
            bottom: TabBar(
              indicatorWeight: 5,
              tabs: <Widget>[
                Tab(
                  child: Obx(
                    () => Badge(
                      badgeContent: Text(
                          privatechatController.unreadCount.value.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      badgeColor: Colors.orange,
                      position: BadgePosition.topEnd(top: -5, end: -30),
                      showBadge: privatechatController.unreadCount.value > 0,
                      child: Text("Chats"),
                    ),
                  ),
                ),
                Tab(
                  text: "Friends",
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            dragStartBehavior: DragStartBehavior.down,
            children: [
              ChatListScreen(),
              FriendListScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
