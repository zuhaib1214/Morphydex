import 'package:get/get.dart';
import 'package:morphydex/res/routes/routes.dart';
import 'package:morphydex/view/auth/login_screen.dart';
import 'package:morphydex/view/auth/signup/sign_up_screen.dart';
import 'package:morphydex/view/get_started/get_started.dart';
import 'package:morphydex/view/home/home_screen.dart';

import '../../view/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() {
    return [
      GetPage(name: Routes.splashScreen, page: () => const SplashScreen()),
      GetPage(name: Routes.getStarted, page: () => const GetStarted()),
      GetPage(name: Routes.signUpScreen, page: () => SignUpScreen()),
      GetPage(name: Routes.signInScreen, page: () => LoginScreen()),
      GetPage(name: Routes.home, page: () => const HomeScreen()),
      // GetPage(name: Routes.profilePicture, page: () => profile()),
    ];
  }
}
