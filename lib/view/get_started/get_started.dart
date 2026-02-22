import 'package:flutter/material.dart';
import 'package:morphydex/view/auth/login_screen.dart';
import 'package:morphydex/view/auth/signup/sign_up_screen.dart';
import 'package:morphydex/view/widgets/buttons.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage(
                  "assets/images/1.png",
                ),
                height: 80,
                width: 80,
              ),
              const SizedBox(
                height: 100,
              ),
              Column(
                children: [
                  const Image(
                    image: AssetImage(
                      "assets/images/2.png",
                    ),
                    height: 120,
                    width: 120,
                  ),
                  const Text(
                    "Let's get started!",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Center(
                      child: Text(
                        "Your journey to baby health begins\nhere. Login and discover",
                        style: TextStyle(fontSize: 16, letterSpacing: 0.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  BGRoundButton(
                    text: "Login",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                  ),
                  WhiteBGTextButton(
                    text: 'SignUp',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
