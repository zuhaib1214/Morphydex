import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphydex/view/widgets/buttons.dart';
import 'package:morphydex/view_model/controllers/signup_controller.dart';

class SignupButtons extends StatelessWidget {
  const SignupButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Obx(() => BGRoundButton(
                text: "SignUp",
                loading: Get.put(SignupController()).loading.value,
                onPressed: () async {
                  // UserCredential? userCredential =
                  //     await FirebaseAuthService.createAccount();
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                  // );
                  Get.put(SignupController()).createAccount();
                },
              )),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already have an account?",
              style: TextStyle(
                color: Color(0xFF707684),
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0.10,
                letterSpacing: 0.50,
              ),
            ),
            const SizedBox(width: 5),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Color(0xFF4ED1EE),
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0.10,
                  letterSpacing: 0.50,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
