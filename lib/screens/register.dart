import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                "Create an account",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                    prefixIcon: Icon(Icons.account_circle)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "First Name",
                    prefixIcon: Icon(Icons.verified_user)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Last Name",
                    prefixIcon: Icon(Icons.verified_user)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Register"),
                ),
              ),
            ),
            Center(child: Text("Already a user?")),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  child: Text("Login"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
