import 'dart:convert';
import 'package:demo_application_web_rtc/utilles/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController(); // Added for sign-up
  Map<String, String> header = {
    'Content-Type': 'application/json'
  };

  RxBool isLoading = false.obs;

  void signIn() async {
    isLoading.value = true;
    Map<String, String> body = {
      "email": emailController.text,
      "password": passwordController.text
    };
    try {
      final response = await http.post(
          Uri.parse('${UrlHolder.baseurl}${UrlHolder.signIn}'),
          headers: header,
          body: jsonEncode(body)
      );

      print('response===================>: ${jsonDecode(response.body)}');
      if (response.statusCode == 200) {
        print('Signed in successfully');
        // Handle successful sign-in, e.g., navigate to home screen
      } else {
        final decodedBody = jsonDecode(response.body);
        final errorMessage = decodedBody['message'] ?? 'An error occurred';
        print('Failed to sign in: $errorMessage');
      }
    } catch (error) {
      print('Sign in===================> failed: $error');
    } finally {
      isLoading.value = false;
    }
  }

  void signUp() async {
    isLoading.value = true;
    Map<String, String> body = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text
    };
    try {
      final response = await http.post(
          Uri.parse('${UrlHolder.baseurl}${UrlHolder.signUp}'),
          headers: header,
          body: jsonEncode(body)
      );

      if (response.statusCode == 201) { // Assuming 201 is success for sign-up
        print('Signed up successfully');
        // Optionally, navigate to sign-in screen or home screen
      } else {
        final decodedBody = jsonDecode(response.body);
        final errorMessage = decodedBody['message'] ?? 'An error occurred';
        print('Sign up failed: $errorMessage');
      }
    } catch (error) {
      print('Sign up===================> failed: $error');
    } finally {
      isLoading.value = false;
    }
  }
}
