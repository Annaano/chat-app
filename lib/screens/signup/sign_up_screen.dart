// import 'package:chat_app/screens/login/login_screen.dart';
import 'package:chat_app/screens/main_screen.dart';
import 'package:chat_app/screens/signup/sign_up_cubit.dart';
import 'package:chat_app/screens/signup/widget/sign_up_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/di/dependency_injections.dart' as di;

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUp';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => di.sl(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpNextMainScreenState) {
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          } else if (state is SignUpNextLoginPageState) {
            // Navigator.of(context).pushNamed(LoginScreen.routeName);
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          } else if (state is SignUpErrorMessageState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return SignUpContent();
        },
      ),
    );
  }
}
