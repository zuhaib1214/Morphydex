import 'package:flutter/material.dart';
import 'package:morphydex/res/app_color.dart';
import 'package:morphydex/res/app_text_styles.dart';
import 'package:morphydex/view_model/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashServices.checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: skinColor,
      // backgroundColor: const Color.fromARGB(255, 63, 63, 63),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Card(
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: 260,
                  width: 350,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage(
                            "assets/images/1.png",
                          ),
                          height: 200,
                          width: 250,
                        ),
                        Text(
                          "Baby Health classification",
                          style: primary20BoldTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class LoginSignupScreen extends StatelessWidget {
//   const LoginSignupScreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Build your login/signup screen UI here
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login / Signup'),
//       ),
//       body: const Center(
//         child: Text('Login and Signup UI goes here'),
//       ),
//     );
//   }
// }
