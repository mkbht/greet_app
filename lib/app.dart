import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greet_app/bindings/bindings.dart';
import 'package:greet_app/screens/dashboard.dart';
import 'package:greet_app/screens/edit_profile.dart';
import 'package:greet_app/screens/forgot_password.dart';
import 'package:greet_app/screens/login.dart';
import 'package:greet_app/screens/profile.dart';
import 'package:greet_app/screens/register.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Greet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialBinding: GetxBindings(),
      initialRoute: '/login',
      getPages: [
        GetPage(name: "/login", page: () => LoginScreen()),
        GetPage(name: "/register", page: () => RegisterScreen()),
        GetPage(name: "/dashboard", page: () => DashboardScreen()),
        GetPage(name: "/forgotPassword", page: () => ForgotPasswordScreen()),
        GetPage(name: "/profile", page: () => ProfileScreen()),
        GetPage(name: "/editProfile", page: () => EditProfileScreen()),
      ],
    );
  }
}
