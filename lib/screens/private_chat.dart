import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:greet_app/controllers/privatechat_controller.dart';
import 'package:greet_app/controllers/profile_controller.dart';
import 'package:greet_app/models/Profile.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PrivateChatScreen extends StatefulWidget {
  const PrivateChatScreen({super.key});

  @override
  State<PrivateChatScreen> createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen> {
  final PrivatechatController privatechatController =
      Get.find<PrivatechatController>();

  final ProfileController profileController = Get.find<ProfileController>();
  var pusher = PusherChannelsFlutter.getInstance();
  List<types.Message> messages = [];
  var timer;

  @override
  void initState() {
    pusher.init(
      apiKey: dotenv.env['PUSHER_APP_KEY']!,
      cluster: dotenv.env['PUSHER_CLUSTER']!,
      onEvent: onEvent,
    );
    pusher.connect();
    super.initState();
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        timer = Timer(Duration(seconds: 3), () async {
          await privatechatController
              .fetchChat(privatechatController.user.value.username!);
          if (pusher.getChannel('chat_8_13') == null) {
            pusher.subscribe(channelName: 'chat_8_13');
          }
        });
      } else {
        timer = Timer.periodic(Duration(seconds: 3), (time) async {
          await privatechatController
              .fetchChat(privatechatController.user.value.username!);
        });
      }
    } else {
      timer = Timer.periodic(Duration(seconds: 3), (time) async {
        await privatechatController
            .fetchChat(privatechatController.user.value.username!);
      });
    }

    setState(() {
      messages = privatechatController.messages;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onEvent(PusherEvent event) {
    if (event.eventName == 'send-message') {
      var data = jsonDecode(event.data);
      final textMessage = types.TextMessage(
        author: types.User(id: data["sender"].toString()),
        createdAt: DateTime.parse(data["created_at"]).millisecondsSinceEpoch,
        id: data["id"].toString(),
        text: data["message"],
      );

      if (privatechatController.user.value.id != data["receiver"]) {
        setState(() {
          messages.insert(0, textMessage);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(privatechatController.user.value.username ?? ""),
          ),
          body: Obx(() => Chat(
                theme: const DefaultChatTheme(
                  inputBackgroundColor: Colors.black12,
                  inputTextColor: Colors.black,
                  inputBorderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                messages: messages,
                onSendPressed: (message) => _handleSendPressed(message),
                onEndReached: () {
                  return Future.value();
                },
                user:
                    types.User(id: profileController.user.value.id.toString()),
              )),
        ));
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: types.User(id: profileController.user.value.id.toString()),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );
    setState(() {
      messages.insert(0, textMessage);
    });
    privatechatController.sendChat(message.text);
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
