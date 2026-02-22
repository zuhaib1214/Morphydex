import 'dart:async';

import 'package:get/get.dart';
import 'package:morphydex/data/shared/shared_pref.dart';
import 'package:morphydex/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res/routes/routes.dart';

class SplashServices {
  static checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? uid = pref.getString('TOKEN');
    Timer(const Duration(milliseconds: 2000), () async {
      if (uid == null) {
        Get.offNamed(Routes.getStarted);
      } else {
        localUser = await UserPref.getUser();
        Get.offNamed(Routes.home);
      }
    });
  }
}
