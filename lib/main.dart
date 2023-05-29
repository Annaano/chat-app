import 'package:flutter/material.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/login/login_screen.dart';
import 'package:chat_app/screens/signup/sign_up_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:chat_app/di/dependency_injections.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();

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
          // colorScheme: ColorScheme.fromSeed(
          //     seedColor: const Color.fromARGB(255, 122, 99, 179)),
        ),
        initialRoute: '/',
        routes: {
          Login.routeName: (context) => const Login(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
        },
        home: const HomeScreen());
  }
}
