import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greet_app/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find<LoginController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView(
          children: <Widget>[
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
                child: Image.asset(
                  'images/logo.png',
                  width: 150,
                ),
              ),
            ),
            Center(
              child: Text(
                "Log In",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: loginController.username,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username or Email",
                    prefixIcon: Icon(Icons.account_circle)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: loginController.password,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    loginController.login();
                  },
                  child: const Text("Login"),
                ),
              ),
            ),
            Center(child: Text("New user?")),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed('/register');
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  child: Text("Create an account"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextButton(
                onPressed: () {
                  Get.toNamed('/forgotPassword');
                },
                child: Text("Forgot Password?"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
