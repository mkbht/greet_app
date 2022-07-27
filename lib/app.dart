import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:greet_app/bindings/bindings.dart';
import 'package:greet_app/screens/chatrooms/chatroom.dart';
import 'package:greet_app/screens/chatrooms/chatroom_list.dart';
import 'package:greet_app/screens/chatrooms/chatroom_page.dart';
import 'package:greet_app/screens/dashboard.dart';
import 'package:greet_app/screens/discover.dart';
import 'package:greet_app/screens/edit_profile.dart';
import 'package:greet_app/screens/forgot_password.dart';
import 'package:greet_app/screens/ice_breaker.dart';
import 'package:greet_app/screens/login.dart';
import 'package:greet_app/screens/profile/follow_list.dart';
import 'package:greet_app/screens/profile/my_profile.dart';
import 'package:greet_app/screens/chats/private_chat.dart';
import 'package:greet_app/screens/register.dart';
import 'package:greet_app/screens/search.dart';
import 'package:greet_app/screens/profile/user_profile.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var storage = GetStorage();
    return GetMaterialApp(
      title: 'Greet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        canvasColor: Colors.white,
      ),
      initialBinding: GetxBindings(),
      initialRoute: storage.read("token") == null ? '/login' : '/dashboard',
      getPages: [
        GetPage(name: "/login", page: () => LoginScreen()),
        GetPage(name: "/register", page: () => RegisterScreen()),
        GetPage(name: "/dashboard", page: () => DashboardScreen()),
        GetPage(name: "/chatrooms", page: () => ChatroomPageScreen()),
        GetPage(name: "/discover", page: () => DiscoverScreen()),
        GetPage(name: "/forgotPassword", page: () => ForgotPasswordScreen()),
        GetPage(name: "/myprofile", page: () => MyProfileScreen()),
        GetPage(name: "/followlist", page: () => FollowListScreen()),
        GetPage(
            name: "/profile", page: () => UserProfileScreen(key: UniqueKey())),
        GetPage(name: "/editProfile", page: () => EditProfileScreen()),
        GetPage(name: "/search", page: () => SearchScreen()),
        GetPage(name: "/privatechat", page: () => PrivateChatScreen()),
        GetPage(name: "/icebreaker", page: () => IceBreakerScreen()),
        GetPage(name: "/chatroom", page: () => ChatroomScreen()),
      ],
    );
  }
}
