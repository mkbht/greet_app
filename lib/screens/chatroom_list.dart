import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greet_app/controllers/chatroom_controller.dart';

class ChatroomListScreen extends StatelessWidget {
  const ChatroomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChatRoomController chatRoomController = Get.find<ChatRoomController>();
    chatRoomController.fetchChatRooms();
    chatRoomController.fetchMyChatRooms();
    chatRoomController.fetchJoinedChatRooms();

    return Obx(
      () => DefaultTabController(
        length: chatRoomController.joinedRooms.length + 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Chatrooms"),
            elevation: 0,
            bottom: TabBar(
              isScrollable: true,
              enableFeedback: true,
              indicatorWeight: 5,
              indicatorColor: Colors.white,
              tabs: () {
                List<Widget> tabs = [];
                tabs.add(Tab(
                  child: Text("Chatrooms"),
                ));
                chatRoomController.joinedRooms.forEach((room) {
                  tabs.add(Tab(
                    child: Text(room.name.toString()),
                  ));
                });
                return tabs;
              }(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.defaultDialog(
                  title: "Create Chatroom",
                  content: Column(
                    children: [
                      TextFormField(
                        controller: chatRoomController.chatRoomName,
                        decoration: InputDecoration(
                          labelText: "Chatroom Name",
                        ),
                      ),
                      TextFormField(
                        controller: chatRoomController.chatRoomDescription,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Description",
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    TextButton(
                      child: Text("Create"),
                      onPressed: () {
                        chatRoomController.createChatroom().then((value) {
                          chatRoomController.fetchChatRooms();
                          chatRoomController.fetchMyChatRooms();
                          chatRoomController.fetchJoinedChatRooms();
                          //Get.back();
                        });
                        Get.back();
                      },
                    ),
                  ]);
            },
            child: Icon(Icons.add),
          ),
          body: Obx(() => RefreshIndicator(
                onRefresh: () async {
                  await chatRoomController.fetchChatRooms();
                  await chatRoomController.fetchMyChatRooms();
                  await chatRoomController.fetchJoinedChatRooms();
                },
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Joined Chatrooms",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    chatRoomController.joinedRooms.isEmpty
                        ? Center(
                            child: ListTile(
                              title: Center(child: Text("No Chatrooms")),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: chatRoomController.joinedRooms.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 0,
                                child: ListTile(
                                  dense: true,
                                  leading: Icon(Icons.forum),
                                  trailing: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 12, // space between two icons
                                    children: <Widget>[
                                      Text(
                                          "${chatRoomController.joinedRooms[index].joined!}/${chatRoomController.joinedRooms[index].capacity!}"), // icon-1
                                      Icon(Icons.chevron_right), // icon-2
                                    ],
                                  ),
                                  title: Text(chatRoomController
                                          .joinedRooms[index].name ??
                                      "N/A"),
                                  onTap: () {
                                    print(index);
                                    chatRoomController.joinChatroom(
                                        chatRoomController
                                            .joinedRooms[index].id);
                                  },
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                height: 0,
                              );
                            },
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Popular Chatrooms",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    chatRoomController.chatRooms.isEmpty
                        ? Center(
                            child: ListTile(
                              title: Center(child: Text("No Chatrooms")),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: chatRoomController.chatRooms.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 0,
                                child: ListTile(
                                  dense: true,
                                  leading: Icon(Icons.forum),
                                  trailing: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 12, // space between two icons
                                    children: <Widget>[
                                      Text(
                                          "${chatRoomController.chatRooms[index].joined!}/${chatRoomController.chatRooms[index].capacity!}"), // icon-1
                                      Icon(Icons.chevron_right), // icon-2
                                    ],
                                  ),
                                  title: Text(chatRoomController
                                          .chatRooms[index].name ??
                                      "N/A"),
                                  onTap: () {
                                    print(index);
                                    chatRoomController.joinChatroom(
                                        chatRoomController.chatRooms[index].id);
                                  },
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                height: 0,
                              );
                            },
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "My Chatrooms",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    chatRoomController.myChatRooms.isEmpty
                        ? Center(
                            child: ListTile(
                              title: Center(child: Text("No Chatrooms")),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: chatRoomController.myChatRooms.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 0,
                                child: ListTile(
                                  dense: true,
                                  leading: Icon(Icons.forum),
                                  trailing: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 12, // space between two icons
                                    children: <Widget>[
                                      Text(
                                          "${chatRoomController.myChatRooms[index].joined!}/${chatRoomController.myChatRooms[index].capacity!}"), // icon-1
                                      Icon(Icons.more_vert), // icon-2
                                    ],
                                  ),
                                  title: Text(chatRoomController
                                          .myChatRooms[index].name ??
                                      "N/A"),
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: "Options",
                                      radius: 8,
                                      content: Column(
                                        children: [
                                          ListTile(
                                            title: Text("Join Chatroom"),
                                            onTap: () {
                                              chatRoomController.joinChatroom(
                                                  chatRoomController
                                                      .myChatRooms[index].id);
                                            },
                                          ),
                                          ListTile(
                                            title: Text("Delete Chatroom"),
                                            onTap: () {
                                              Get.defaultDialog(
                                                barrierDismissible: false,
                                                title: "Delete Chatroom",
                                                actions: [
                                                  TextButton(
                                                    child: Text("Cancel"),
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text("Delete"),
                                                    onPressed: () {
                                                      chatRoomController
                                                          .deleteChatroom(
                                                              chatRoomController
                                                                  .myChatRooms[
                                                                      index]
                                                                  .id)
                                                          .then((value) {
                                                        chatRoomController
                                                            .fetchChatRooms();
                                                        chatRoomController
                                                            .fetchMyChatRooms();
                                                        Timer(
                                                            Duration(
                                                                seconds: 1),
                                                            () async {
                                                          Get.back(
                                                              closeOverlays:
                                                                  true);
                                                        });
                                                        //.back(closeOverlays: true);
                                                      }).catchError((error) {
                                                        Get.back(
                                                            closeOverlays:
                                                                true);
                                                      });
                                                      if (chatRoomController
                                                          .isLoading.value) {
                                                        Get.defaultDialog(
                                                          title: "Deleting...",
                                                          barrierDismissible:
                                                              false,
                                                          content: Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                                content: Center(
                                                  child: Text(
                                                      "Are you sure you want to delete the chatroom?"),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                height: 0,
                              );
                            },
                          ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
