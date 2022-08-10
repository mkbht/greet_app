import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:greet_app/models/Story.dart';
import 'package:http/http.dart' as http;

class StoryController extends GetxController {
  final storage = GetStorage();
  final stories = <Story>[].obs;
  final isLoading = false.obs;

  Future fetchStories() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('${dotenv.env['API_URL']}/stories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${storage.read("token")}',
        },
      );

      if (response.statusCode == 200) {
        print("success");
        List<Story> getStories = List<Story>.from(
            jsonDecode(response.body).map((x) => Story.fromJson(x)));
        stories.value = getStories;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        Get.snackbar(
          "Error",
          "Failed to load stories.",
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
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
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
