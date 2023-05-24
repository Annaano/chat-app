import 'package:flutter/material.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/login/login_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat',
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 122, 99, 179)),
        ),
        initialRoute: '/',
        routes: {
          Login.routeName: (context) => const Login(),
        },
        home: const HomeScreen());
  }
}
