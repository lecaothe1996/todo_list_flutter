import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/widgets/login/ctrl.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginCtrl loginCtrl = Get.put(LoginCtrl());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: loginCtrl.emailTextEditingCtrl,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: loginCtrl.passwordTextEditingCtrl,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => loginCtrl.onLogIn(),
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => loginCtrl.onForgotPassword(),
              child: const Text('Forgot password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => loginCtrl.onLoginWithGoogle(),
              child: const Text('Login with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
