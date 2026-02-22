import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphydex/res/app_text_styles.dart';
import 'package:morphydex/view_model/controllers/signup_controller.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
    super.key,
  });

  final controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name',
              style: black18BoldTextStyle,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.name.value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                hintText: "Enter Your Name",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Email',
              style: black18BoldTextStyle,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.email.value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: "Enter Your Email",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Password',
              style: black18BoldTextStyle,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.password.value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  icon: controller.showPassword.value
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () => controller.togglePassword(),
                ),
                hintText: 'Enter Your Password',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),
              ),
              obscureText: controller.showPassword.value,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ],
        ));
  }
}
