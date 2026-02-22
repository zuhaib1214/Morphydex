import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphydex/data/shared/shared_pref.dart';
import 'package:morphydex/main.dart';
import 'package:morphydex/models/user_model.dart';
import 'package:morphydex/res/app_collections.dart';
import 'package:morphydex/utils/utils.dart';
import 'package:morphydex/view/get_started/get_started.dart';
import 'package:morphydex/view/home/home_screen.dart';
import 'package:morphydex/view_model/controllers/login_controller.dart';
import 'package:morphydex/view_model/controllers/signup_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final signUpController = Get.put(SignupController());
  static final signInController = Get.put(LoginController());
  static Future<UserCredential?> createAccount({required pictureUrl}) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: signUpController.email.value.text,
      password: signUpController.password.value.text,
    );
    final user = UserModel(
        profilePicture: pictureUrl,
        name: signUpController.name.value.text,
        token: userCredential.user!.uid,
        email: signUpController.email.value.text);

    log("user name signup ${user.name}");
    await db
        .collection(AppCollections.usersCollection)
        .doc(user.token)
        .set(user.toMap());
    UserPref.setUser(user: user);
    localUser = user;
    return userCredential;
  }

  static logout() async {
    try {
      _auth.signOut();
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.clear();
      Get.offAll(() => const GetStarted());
    } catch (e) {
      print(e);
    }
  }

  static Future<UserCredential?> loginAccount() async {
    try {
      signInController.setLoading(true);
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: signInController.email.value.text,
          password: signInController.password.value.text);

      final snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      UserModel userModel = UserModel.fromMap(snap.data()!);
      localUser = userModel;
      UserPref.setUser(user: userModel);
      signInController.setLoading(false);
      Get.offAll(() => const HomeScreen());
      return userCredential;
    } catch (e) {
      signInController.setLoading(false);
      Utils.showSnackBar(
          'Warning',
          e.toString(),
          const Icon(
            Icons.warning_amber,
            color: Colors.red,
          ));
      print('Error signing in: $e');
      return null;
    }
  }

  static String getCurrentUserID() {
    User user = _auth.currentUser!;
    return user.uid;
  }
}
