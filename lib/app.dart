import 'package:flutter/material.dart';
import 'package:greet_app/screens/login.dart';
import 'package:greet_app/screens/register.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/login',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => const LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
