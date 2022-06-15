import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username or Email",
                    prefixIcon: Icon(Icons.account_circle)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
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
                  onPressed: () {},
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
                    Navigator.pushNamed(context, '/register');
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
                onPressed: () {},
                child: Text("Forgot Password?"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
