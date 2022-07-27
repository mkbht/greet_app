import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:greet_app/controllers/privatechat_controller.dart';
import 'package:greet_app/controllers/profile_controller.dart';
import 'package:greet_app/screens/chats/stories.dart';
import 'package:greet_app/screens/profile/my_profile.dart';
import 'package:intl/intl.dart';
import 'package:stories_for_flutter/stories_for_flutter.dart';
import 'package:stories_for_flutter/story_circle.dart';
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stories(
                  displayProgress: true,
                  storyItemList: [
                    // First group of stories
                    StoryItem(
                        name: "harmon35",
                        thumbnail: NetworkImage(
                          "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
                        ),
                        stories: [
                          // First story
                          Scaffold(
                            body: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://wallpaperaccess.com/full/16568.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Second story in first group
                          Scaffold(
                            body: Center(
                              child: Text(
                                "harmon35",
                                style: TextStyle(
                                  color: Color(0xff777777),
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        ]),
                    // Second story group
                    StoryItem(
                      name: "rita6",
                      thumbnail: NetworkImage(
                        "https://www.shareicon.net/data/512x512/2017/03/29/881758_cup_512x512.png",
                      ),
                      stories: [
                        Scaffold(
                          body: Center(
                            child: Text(
                              "That's it, Folks !",
                              style: TextStyle(
                                color: Color(0xff777777),
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
