import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greet_app/controllers/privatechat_controller.dart';
import 'package:greet_app/controllers/profile_controller.dart';
import 'package:greet_app/screens/my_profile.dart';
import 'package:intl/intl.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PrivatechatController privatechatController =
        Get.find<PrivatechatController>();
    ProfileController profileController = Get.find<ProfileController>();

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          constraints: BoxConstraints(maxHeight: 96.0),
          decoration: BoxDecoration(color: Color.fromRGBO(240, 240, 240, 1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                radius: 24.0,
                backgroundColor: Colors.black38,
                child: InkWell(
                  onTap: () {
                    Get.toNamed("/myprofile");
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 23.0,
                    foregroundImage: profileController.profile.value.avatar !=
                            null
                        ? NetworkImage(profileController.profile.value.avatar!)
                        : null,
                    backgroundImage: AssetImage('assets/images/user.jpg'),
                  ),
                ),
              ),
              Text("Chats"),
              IconButton(
                onPressed: () {
                  Get.toNamed("/search");
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(
            () => RefreshIndicator(
              onRefresh: () async {
                await privatechatController.fetchChatList();
              },
              child: ListView.builder(
                itemCount: privatechatController.chatList.length,
                itemBuilder: ((context, index) {
                  final chatUser = privatechatController.chatList;
                  return Card(
                    elevation: 0,
                    child: ListTile(
                      onTap: () {
                        privatechatController
                            .fetchChat(chatUser[index].username!);
                        Get.toNamed("privatechat");
                      },
                      title: Text(
                        "${chatUser[index].username}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("${chatUser[index].lastMessage}"),
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.primaries[
                            Random(chatUser[index].id)
                                .nextInt(Colors.primaries.length)],
                        foregroundImage: chatUser[index].avatar != null
                            ? NetworkImage(chatUser[index].avatar!)
                            : null,
                        child: Text(
                          chatUser[index].username![0].toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            chatUser[index].sentAt != null
                                ? DateFormat('yMMMd').format(
                                    DateTime.parse(chatUser[index].sentAt!))
                                : "",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            chatUser[index].sentAt != null
                                ? DateFormat('jms').format(
                                    DateTime.parse(chatUser[index].sentAt!))
                                : "",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
