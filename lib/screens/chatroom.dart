import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:greet_app/controllers/chatroom_controller.dart';
import 'package:greet_app/models/Chatroom.dart';

class ChatroomScreen extends StatelessWidget {
  ChatroomScreen({super.key});
  final parameters = Get.parameters;

  @override
  Widget build(BuildContext context) {
    ChatRoomController chatroomController = Get.find<ChatRoomController>();
    var room = chatroomController.joinedRooms
        .indexWhere((room) => room.id == int.parse(parameters["id"]!));

    return Scaffold(
      appBar: AppBar(
        title: Text(parameters['name'] ?? 'Chatroom'),
        elevation: 0,
      ),
      body: Obx(() => Stack(
            children: <Widget>[
              ListView.builder(
                  itemCount: room != -1
                      ? chatroomController.joinedRooms[room].messages?.length
                      : 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      dense: true,
                      title: Wrap(children: [
                        Text(
                          '${chatroomController.joinedRooms[room].messages![index].sender}: ',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          '${chatroomController.joinedRooms[room].messages![index].message}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ]),
                    );
                  }),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: chatroomController.messageField,
                          decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          chatroomController
                              .sendMessage(int.parse(parameters["id"]!))
                              .then((value) =>
                                  chatroomController.messageField.text = '');
                        },
                        elevation: 0,
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
