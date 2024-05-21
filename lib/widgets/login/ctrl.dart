import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:to_do_list/base_widget/my_dialog.dart';
import 'package:to_do_list/routes/app_pages.dart';
import 'package:to_do_list/sharedpref/key_preference.dart';
import 'package:to_do_list/sharedpref/shared_preference.dart';

class LoginCtrl extends GetxController {
  TextEditingController emailTextEditingCtrl = TextEditingController();
  TextEditingController passwordTextEditingCtrl = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void onClose() {
    super.onClose();
    emailTextEditingCtrl.dispose();
    passwordTextEditingCtrl.dispose();
  }

  @override
  void onInit() async {
    super.onInit();
    Future.delayed(const Duration(seconds: 0), () {
      _checkLogin();
    });
  }

  void _checkLogin() {
    final isLogin = SharedPreference.getBool(KeyPreferences.is_login);
    if (isLogin) {
      Get.offAndToNamed(AppPages.HOME);
    }
  }

  void onLogIn() async {
    EasyLoading.show();
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailTextEditingCtrl.text,
        password: passwordTextEditingCtrl.text,
      );

      if (userCredential.user?.uid != null) {
        await _saveUserData(userCredential);
        Get.offAndToNamed(AppPages.HOME);
      } else {
        print('no user!');
      }
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      EasyLoading.showError(e.code);
    }
  }

  void onLoginWithGoogle() async {
    EasyLoading.show();
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      // print('idToken==${googleAuth.idToken}');
      // print('accessToken==${googleAuth.accessToken}');
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(authCredential);

      if (userCredential.user?.uid != null) {
        await _saveUserData(userCredential);
        Get.offAndToNamed(AppPages.HOME);
      } else {
        print('no user!');
      }
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      EasyLoading.showError(e.code);
    }
  }

  Future<void> _saveUserData(UserCredential userCredential) async {
    await SharedPreference.setBool(KeyPreferences.is_login, true);
    await SharedPreference.setString(KeyPreferences.user_id, userCredential.user?.uid ?? '');
    await SharedPreference.setString(KeyPreferences.user_email, userCredential.user?.email ?? '');
  }

  void onForgotPassword() async {
    MyDialog.showDialog(
      callback: (email) async {
        EasyLoading.show();
        try {
          await _auth.sendPasswordResetEmail(email: email);
          EasyLoading.dismiss();
        } on FirebaseAuthException catch (e) {
          print('Error: $e');
          EasyLoading.showError(e.code);
        }
      },
    );
  }
}
