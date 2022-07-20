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

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chatrooms"),
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Chatrooms"),
            ],
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
              },
              child: ListView(
                children: [
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
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: chatRoomController.chatRooms.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                dense: true,
                                trailing: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 12, // space between two icons
                                  children: <Widget>[
                                    Text(
                                        "${chatRoomController.chatRooms[index].joined!}/${chatRoomController.chatRooms[index].capacity!}"), // icon-1
                                    Icon(Icons.chevron_right), // icon-2
                                  ],
                                ),
                                title: Text(
                                    chatRoomController.chatRooms[index].name ??
                                        "N/A"),
                                onTap: () {},
                              ),
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
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: chatRoomController.myChatRooms.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                dense: true,
                                trailing: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 12, // space between two icons
                                  children: <Widget>[
                                    Text(
                                        "${chatRoomController.chatRooms[index].joined!}/${chatRoomController.myChatRooms[index].capacity!}"), // icon-1
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
                                            Get.toNamed('/chatroom',
                                                parameters: {
                                                  'name': chatRoomController
                                                      .myChatRooms[index].name!,
                                                  'id': chatRoomController
                                                      .myChatRooms[index].id!
                                                      .toString(),
                                                });
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
                                                                .id!)
                                                        .then((value) {
                                                      chatRoomController
                                                          .fetchChatRooms();
                                                      chatRoomController
                                                          .fetchMyChatRooms();
                                                      Timer(
                                                          Duration(seconds: 1),
                                                          () async {
                                                        Get.back(
                                                            closeOverlays:
                                                                true);
                                                      });
                                                      //.back(closeOverlays: true);
                                                    }).catchError((error) {
                                                      Get.back(
                                                          closeOverlays: true);
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
                        ),
                ],
              ),
            )),
      ),
    );
    ;
  }
}
