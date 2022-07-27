import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:greet_app/controllers/privatechat_controller.dart';
import 'package:greet_app/controllers/profile_controller.dart';
import 'package:greet_app/screens/profile/my_profile.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PrivatechatController privatechatController =
        Get.find<PrivatechatController>();

    return Obx(
      () => RefreshIndicator(
        onRefresh: () async {
          await privatechatController.fetchChatList();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                itemCount: privatechatController.chatList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  final chatUser = privatechatController.chatList;
                  bool seen;
                  if (chatUser[index].seenAt == null) {
                    if (chatUser[index].senderId ==
                        chatUser[index].receiverId) {
                      seen = true;
                    } else {
                      seen = false;
                    }
                  } else {
                    seen = true;
                  }
                  return Card(
                    elevation: 0,
                    child: ListTile(
                      onTap: () {
                        Get.toNamed("privatechat", parameters: {
                          "id": chatUser[index].senderId.toString()
                        });
                      },
                      title: Text(
                        "${chatUser[index].username}",
                        style: TextStyle(
                          fontWeight:
                              seen ? FontWeight.normal : FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        "${chatUser[index].lastMessage}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              seen ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                      isThreeLine: false,
                      leading: Badge(
                        showBadge: false,
                        position: BadgePosition.bottomEnd(bottom: 0, end: 0),
                        padding: EdgeInsets.all(7),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        badgeColor: Colors.grey,
                        child: CircleAvatar(
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
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            chatUser[index].sentAt != null
                                ? timeago.format(
                                    DateTime.parse(chatUser[index].sentAt!),
                                    locale: 'en_short',
                                  )
                                : "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight:
                                  seen ? FontWeight.normal : FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
