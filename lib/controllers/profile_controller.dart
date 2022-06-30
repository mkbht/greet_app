import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:greet_app/models/Profile.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final dateOfBirth = TextEditingController();
  final storage = GetStorage();
  final user = Profile().obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyProfile();
  }

  @override
  void onClose() {
    super.onClose();
    firstName.dispose();
    lastName.dispose();
    dateOfBirth.dispose();
  }

  Future fetchMyProfile() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.2.15:3333/api/myprofile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${storage.read("token")}',
        },
      );

      if (response.statusCode == 200) {
        Profile profile = Profile.fromJson(jsonDecode(response.body));
        user.value = profile;
        firstName.text = profile.firstName ?? "";
        lastName.text = profile.lastName ?? "";
        dateOfBirth.text = profile.dateOfBirth ?? "";
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        Get.snackbar(
          "Error",
          "Can't load profile",
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
    }
  }

  Future updateProfile() async {
    try {
      final response = await http.put(
          Uri.parse('http://192.168.2.15:3333/api/updateprofile'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${storage.read("token")}',
          },
          body: jsonEncode(<String, String>{
            'first_name': firstName.text,
            'last_name': lastName.text,
            'date_of_birth': dateOfBirth.text
          }));

      if (response.statusCode == 200) {
        Profile profile = Profile.fromJson(jsonDecode(response.body));
        user.value = profile;
        firstName.text = profile.firstName ?? "";
        lastName.text = profile.lastName ?? "";
        dateOfBirth.text = profile.dateOfBirth ?? "";
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        Get.snackbar(
          "Error",
          "Can't load profile",
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
    }
  }
}
