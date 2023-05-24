import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  static const routeName = '/logingit ';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                child: Text(
                  textAlign: TextAlign.center,
                  "Find your all frineds in one place by signing the apps quick & easily.",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  child: const Text(
                    'Have an account? Login',
                    style: TextStyle(
                        color: Colors.white,
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: const Color(0xFFe6f5ff),
                  ),
                  child: Text(
                    "Join us, it's free",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
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
