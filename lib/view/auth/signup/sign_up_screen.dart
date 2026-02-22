import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphydex/view/auth/signup/components/signup_buttons.dart';
import 'package:morphydex/view/auth/signup/components/signup_form.dart';
import 'package:morphydex/view/widgets/custom_app_bar.dart';
import 'package:morphydex/view_model/controllers/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final controller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'SignUp',
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Image(
                          image: AssetImage(
                            "assets/images/2.png",
                          ),
                          height: 100,
                          width: 100,
                        ),
                        Obx(() => GestureDetector(
                              onTap: () => controller.picImage(),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: controller
                                        .profilePicture.isEmpty
                                    ? null
                                    : FileImage(
                                        File(controller.profilePicture.value)),
                                child: controller.profilePicture.isEmpty
                                    ? const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                            Text(
                                              'Pic Image',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      )
                                    : null,
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SignUpForm(),
                  const SizedBox(height: 10),
                  const SignupButtons(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
