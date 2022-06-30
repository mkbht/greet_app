import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greet_app/screens/profile.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Get.toNamed("/profile");
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 23.0,
                    backgroundImage: AssetImage('images/user.jpg'),
                  ),
                ),
              ),
              Text("Chats"),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: const [
              Text("hello"),
              Text("hello"),
            ],
          ),
        ),
      ],
    );
  }
}
