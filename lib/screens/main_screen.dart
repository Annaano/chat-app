import 'package:chat_app/screens/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/login/login_screen.dart';
import 'package:chat_app/core/const/color_consts.dart';
import 'package:chat_app/core/const/text_consts.dart';

// import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConsts.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                width: 800,
                child: Image.asset('assets/images/chatting.jpg'),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: const Text(
                  textAlign: TextAlign.center,
                  TextConsts.introductionTitle,
                  style: TextStyle(
                      color: ColorConsts.mainColor,
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).pushNamed(Login.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: ColorConsts.mainColor),
                  child: const Text(
                    TextConsts.login,
                    style: TextStyle(
                        color: ColorConsts.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignUpScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: ColorConsts.secondMainColor,
                  ),
                  child: const Text(
                    TextConsts.signUp,
                    style: TextStyle(
                        color: ColorConsts.mainColor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )

              // Card(
              //   margin: const EdgeInsets.all(20),
              //   child: SingleChildScrollView(
              //     child: Padding(
              //       padding: const EdgeInsets.all(16),
              //       child: Form(
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             TextFormField(
              //               decoration:
              //                   InputDecoration(labelText: 'Email Address'),
              //               keyboardType: TextInputType.emailAddress,
              //               autocorrect: false,
              //               textCapitalization: TextCapitalization.none,
              //             ),
              //             TextFormField(
              //               decoration: InputDecoration(labelText: 'Password'),
              //               obscureText: true,
              //             ),
              //             SizedBox(
              //               height: 12,
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
