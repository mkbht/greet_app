import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greet_app/controllers/privatechat_controller.dart';
import 'package:greet_app/controllers/profile_controller.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find<ProfileController>();
    PrivatechatController privatechatController =
        Get.find<PrivatechatController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Obx(
        () => profileController.isProfileLoading.value
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Text(
                          "@${profileController.profile.value.username ?? ''}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 80,
                        //backgroundImage: AssetImage("assets/images/user.jpg"),
                        backgroundColor: Colors.blue,
                        child: Text(
                          profileController.profile.value.username != null
                              ? profileController.profile.value.username![0]
                                  .toUpperCase()
                              : "Greet",
                          style: TextStyle(
                            fontSize: 48,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Text(
                          "${profileController.profile.value.firstName ?? ''} ${profileController.profile.value.lastName ?? ''}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 0),
                        child: Text(
                          "Hi, I am using greet app.",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() => ElevatedButton(
                                  onPressed: () {
                                    var isFollowing =
                                        profileController.isFollowing.value;
                                    if (isFollowing) {
                                      profileController.unfollow(
                                          profileController.profile.value.id!);
                                    } else {
                                      profileController.follow(
                                          profileController.profile.value.id!);
                                    }
                                  },
                                  child: (profileController.isFollowing.value)
                                      ? Text("Unfollow")
                                      : Text("+ Follow"),
                                )),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                privatechatController.fetchChat(
                                    profileController.profile.value.username!);
                                Get.toNamed("privatechat");
                              },
                              child: Text("Message"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${profileController.profile.value.followers?.length}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text("Followers")
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "${profileController.profile.value.followings?.length}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text("Followings")
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Card(
                      child: ListTile(
                        onTap: () {},
                        leading: CircleAvatar(
                          child: Icon(Icons.block),
                        ),
                        title: Text("Block User"),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
