import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/Login.dart';

class LoginController extends GetxController {
  final username = TextEditingController();
  final password = TextEditingController();
  final isLoading = false.obs;
  final storage = GetStorage();

  @override
  void onClose() {
    super.onClose();
    username.dispose();
    password.dispose();
  }

  Future login() async {
    print("Login button hit");
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username.text,
          'password': password.text
        }),
      );

      if (response.statusCode == 200) {
        Login loginData = Login.fromJson(jsonDecode(response.body));
        storage.write("bearer", loginData.type);
        storage.write("token", loginData.token);
        // After success
        Get.snackbar(
          "Success",
          "Logged in successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed('/dashboard');
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        Get.snackbar(
          "Error",
          jsonDecode(response.body)['message'],
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } on Exception {
      Get.snackbar(
        "Error",
        "Could not connect to server.",
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
