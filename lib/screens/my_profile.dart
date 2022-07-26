import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greet_app/controllers/main_menu_controller.dart';
import 'package:greet_app/controllers/profile_controller.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find<ProfileController>();
    MainMenuController mainMenuController = Get.find<MainMenuController>();
    profileController.fetchMyProfile();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Profile"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: mainMenuController.selectedIndex.value,
          items: mainMenuController.menu,
          onTap: mainMenuController.onTap,
        ),
        body: profileController.user.value.username == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Text(
                          "@${profileController.user.value.username ?? ''}",
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
                        foregroundImage: profileController.user.value.avatar !=
                                null
                            ? NetworkImage(profileController.user.value.avatar!)
                            : null,
                        backgroundColor: Colors.blue,
                        child: Text(
                          profileController.user.value.username != null
                              ? profileController.user.value.username![0]
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
                          "${profileController.user.value.firstName ?? ''} ${profileController.user.value.lastName ?? ''}",
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
                                "10",
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
                                "26",
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
                        onTap: () {
                          Get.toNamed("editProfile");
                        },
                        leading: CircleAvatar(
                          child: Icon(Icons.edit),
                        ),
                        title: Text("Edit Profile"),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.settings),
                        ),
                        title: Text("Settings"),
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
