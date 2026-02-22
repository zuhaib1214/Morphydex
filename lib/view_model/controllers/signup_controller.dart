import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morphydex/data/network/file_services.dart';
import 'package:morphydex/data/network/firebase/auth_services.dart';
import 'package:morphydex/utils/utils.dart';
import 'package:morphydex/view/home/home_screen.dart';

class SignupController extends GetxController {
  RxBool nameFocus = false.obs;
  RxBool emailFocus = false.obs;
  RxBool passwordFocus = false.obs;
  RxBool correctEmail = false.obs;
  RxBool correctName = false.obs;
  final showPassword = true.obs;
  RxBool loading = false.obs;
  RxString profilePicture = ''.obs;
  // final FirebaseServices firebase=FirebaseServices();
  final email = TextEditingController().obs;
  final name = TextEditingController().obs;
  final password = TextEditingController().obs;

  void togglePassword() {
    showPassword.value = !showPassword.value;
  }

  void validateName() {
    correctName.value = name.value.text.toString().isNotEmpty;
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  picImage() async {
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker != null) {
      profilePicture.value = picker.path;
    }
  }

  Future<void> createAccount() async {
    if (!loading.value) {
      if (name.value.text.toString().isEmpty) {
        Utils.showSnackBar(
            'Warning',
            'Enter Correct Name',
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.pink,
            ));
        return;
      }
      if (!Utils.validateEmail(email.value.text.toString())) {
        Utils.showSnackBar(
            'Warning',
            'Enter Correct Email',
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.pink,
            ));
        return;
      }
      if (password.value.text.toString().length < 6) {
        Utils.showSnackBar(
            'Warning',
            'Password length should greater than 5',
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.pink,
            ));
        return;
      }

      if (profilePicture.isEmpty) {
        Utils.showSnackBar(
            'Warning',
            'Enter Set Profile Picture',
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.pink,
            ));
        return;
      }

      try {
        setLoading(true);
        await FirebaseAuthService.createAccount(
            pictureUrl: await FileServices.uploadFile(
                filePath: profilePicture.value,
                uploadPath:
                    'profilePicture/${DateTime.now().microsecondsSinceEpoch.toString()}.jpeg')
            // email: email.value.text,
            // name: name.value.text,
            // password: password.value.text,
            );
        setLoading(false);
        Get.offAll(() => const HomeScreen());
        name.value.clear();
        profilePicture.value = '';
        password.value.clear();
        email.value.clear();
      } catch (_) {
        print(_.toString());
        setLoading(false);
        Utils.showSnackBar(
            'Error',
            _.toString(),
            const Icon(
              Icons.warning_amber,
              color: Colors.red,
            ));
      }
    }
  }

  void onFocusEmail() {
    emailFocus.value = true;
    nameFocus.value = false;
    passwordFocus.value = false;
  }

  void onFocusName() {
    emailFocus.value = false;
    nameFocus.value = true;
    passwordFocus.value = false;
  }

  void onFocusPassword() {
    emailFocus.value = false;
    nameFocus.value = false;
    passwordFocus.value = true;
  }

  void validateEmail() {
    correctEmail.value = Utils.validateEmail(email.value.text.toString());
  }

  void onTapOutside(BuildContext context) {
    emailFocus.value = false;
    nameFocus.value = false;
    passwordFocus.value = false;
    FocusScope.of(context).unfocus();
  }
}
