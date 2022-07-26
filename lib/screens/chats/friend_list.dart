import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greet_app/controllers/profile_controller.dart';

class FriendListScreen extends StatelessWidget {
  const FriendListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find<ProfileController>();

    return Obx(() => Scaffold(
          body: ListView.separated(
              itemCount: profileController.user.value.followings?.length ?? 0,
              itemBuilder: (context, index) {
                var followings = profileController.user.value.followings!;
                return ListTile(
                  title: Text(followings[index].username ?? ""),
                  subtitle: Text(
                      "${followings[index].firstName ?? ""} ${followings[index].lastName ?? ""}"),
                  leading: Badge(
                    showBadge: true,
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
                          Random(followings[index].id)
                              .nextInt(Colors.primaries.length)],
                      foregroundImage: followings[index].avatar != null
                          ? NetworkImage(followings[index].avatar!)
                          : null,
                      child: Text(
                        followings[index].username![0].toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 0,
                );
              }),
        ));
  }
}
