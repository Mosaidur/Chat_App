import 'dart:convert';
import 'package:demo_application_web_rtc/utilles/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Map<String, String> header = {
    'Content-Type': 'application/json'
  };

  RxBool isLoading = false.obs;

  void signIn() async {
    isLoading.value = true;
    Map<String, String> body = {
      "email": "tanvi",
      "password": "123"
    };
    try {
      final response = await http.post(
          Uri.parse('${UrlHolder.baseurl}${UrlHolder.signIn}'),
          headers: header,
          body: jsonEncode(body) // Encode the body as JSON
      );

      print('response===================> failed: ${jsonDecode(response.body)}');
      if (response.statusCode == 200) {

        print('Signed in successfully');

        // Navigate to home screen or handle response
      } else {

        final decodedBody = jsonDecode(response.body);
        final errorMessage = decodedBody['message'] ?? 'An error occurred';

        print('Failed to sign in: ${errorMessage}');


      }
      isLoading.value = false;
    } catch (error) {
      print('Sign in===================> failed: ${error}');
      Get.snackbar("Error", '${error}');
      isLoading.value = false;
    }
  }

//
  // void signUp() async {
  //   final response = await http.post(
  //     Uri.parse('https://your-backend.com/api/signup'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'name': name.value,
  //       'email': email.value,
  //       'password': password.value,
  //     }),
  //   );
  //
  //   if (response.statusCode == 201) {
  //     // Successfully signed up
  //     print('Signed up successfully');
  //     Get.snackbar('Success', 'Signed up successfully');
  //     // Optionally navigate to sign-in screen
  //   } else {
  //     // Sign-up failed
  //     print('Sign up failed: ${response.body}');
  //     Get.snackbar('Error', 'Sign-up failed');
  //   }
  // }
}
