import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphydex/view/auth/signup/sign_up_screen.dart';
import 'package:morphydex/view/widgets/buttons.dart';
import 'package:morphydex/view/widgets/custom_app_bar.dart';
import 'package:morphydex/view_model/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  // bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Login",
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Center(
                      child: Image(
                        image: AssetImage(
                          "assets/images/1.png",
                        ),
                        height: 120,
                        width: 120,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Email',
                        style: TextStyle(
                          color: Color(0xFF101522),
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0.08,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: "Enter Your Email",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                          )),
                      keyboardType: TextInputType.emailAddress,
                      // keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: controller.email.value,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Password',
                        style: TextStyle(
                          color: Color(0xFF101522),
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0.08,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => TextFormField(
                        controller: controller.password.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        obscureText: controller.showPassword.value,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: Obx(() => IconButton(
                                icon: controller.showPassword.value
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                onPressed: () {
                                  controller.showPassword.value =
                                      !controller.showPassword.value;
                                },
                              )),
                          //  const Icon(Icons.remove_red_eye),
                          hintText: 'Enter Your Password',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const SizedBox(height: 50),
                    Center(
                      child: Obx(() => BGRoundButton(
                          text: "Login",
                          loading: controller.loading.value,
                          onPressed: () async {
                            // if (_formKey.currentState!.validate()) {
                            //   await FirebaseAuthService.loginAccount();
                            //   // ignore: use_build_context_synchronously
                            //   Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const HomeScreen()),
                            //   );
                            // }
                            if (!controller.loading.value) {
                              controller.loginAccount();
                            }
                          })),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account?",
                          style: TextStyle(
                            color: Color(0xFF707684),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                            letterSpacing: 0.50,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(SignUpScreen());
                          },
                          child: const Text(
                            "Sign Up",
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
                    const SizedBox(
                      height: 30,
                    ),
                    // const Center(
                    //   child: Text(
                    //     "OR",
                    //     style: TextStyle(
                    //       color: Color(0xFFA0A7B0),
                    //       fontSize: 16,
                    //       fontFamily: 'Inter',
                    //       fontWeight: FontWeight.w400,
                    //       height: 0.09,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 50,
                    // ),
                    // const Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Image(
                    //         image: NetworkImage(
                    //             "https://i.postimg.cc/jSD8Xd5Q/Google.png")),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(top: 6),
                    //       child: Text(
                    //         "Sign in with Google",
                    //         style: TextStyle(
                    //           color: Color(0xFF101522),
                    //           fontSize: 16,
                    //           fontFamily: 'Inter',
                    //           fontWeight: FontWeight.w600,
                    //           height: 0.09,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
