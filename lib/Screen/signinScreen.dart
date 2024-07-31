import 'package:demo_application_web_rtc/Screen/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controller/signIn_Controller.dart';
// import 'auth_controller.dart';



class SignInScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(()=> authController.isLoading.value?const Center(child: CircularProgressIndicator()): Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Email TextField with Obx
            TextField(
              controller: authController.emailController,

              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Password TextField with Obx
     TextField(
              controller: authController.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Sign In Button (doesn't need Obx since it's not reactive)
            ElevatedButton(
              onPressed: authController.signIn,
              child: const Text('Sign In'),
            ),

            // Sign Up Navigation Button
            TextButton(
              onPressed: () {
                Get.to(() => SignUpScreen());
              },
              child: const Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
        )
      ),
    );
  }
}
