import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:greet_app/controllers/privatechat_controller.dart';

class IceBreakerScreen extends StatelessWidget {
  const IceBreakerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PrivatechatController privatechatController =
        Get.find<PrivatechatController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Ice Breaker"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.ice_skating,
              size: 120,
              color: Colors.indigo,
            ),
            ElevatedButton(
              onPressed: () {
                privatechatController.iceBreaker().then((value) {
                  privatechatController
                      .fetchChat(privatechatController.user.value.username!);
                  Get.toNamed("privatechat");
                });
              },
              child: Text("Break the ice"),
            ),
          ],
        ),
      ),
    );
  }
}
