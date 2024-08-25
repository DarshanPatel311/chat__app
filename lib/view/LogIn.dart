import 'package:chat_box/firebase_sarvice/firebase_notificton/FirebaseMessagingServices.dart';
import 'package:chat_box/view/home_screen.dart';
import 'package:chat_box/view/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../Controller/login.dart';
import '../firebase_sarvice/User.dart';
import '../firebase_sarvice/google_services.dart';
import '../model/data_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SignInController());

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.05,
              width: double.infinity,
            ),
            Container(
              height: screenHeight * 0.35,
              width: screenWidth * 0.8,
              child: Image.asset('assets/img/login.png'),
            ),
            Text(
              "Sign In",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.09,
                  // Font size based on screen width
                  color: Colors.white),
            ),
            SizedBox(
              height: screenHeight * 0.03, // 3% of screen height
            ),
            Container(
              height: screenHeight * 0.06, // 6% of screen height
              width: screenWidth * 0.9, // 90% of screen width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white12,
              ),
              child: TextField(
                decoration: InputDecoration(
                    label: Text(
                      "Email",
                      style: TextStyle(color: Colors.white),
                    ),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02, // 2% of screen height
            ),
            Container(
              height: screenHeight * 0.06, // 6% of screen height
              width: screenWidth * 0.9, // 90% of screen width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white12,
              ),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    label: Text(
                      "Password",
                      style: TextStyle(color: Colors.white),
                    ),
                    prefixIcon: Icon(
                      Icons.lock_open,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.50, top: screenHeight * 0.01),
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:
                      screenWidth * 0.04, // Adjusted for better visibility
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Stack(
              children: [
                Container(
                    height: 80,
                    width: 350,
                    child: Image.asset('assets/img/Social media-uihut@3x.png')),
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 12),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
                //Google
                Padding(
                  padding: const EdgeInsets.only(left: 150, top: 12),
                  child: InkWell(
                    onTap: () async {
                      String status = await GoogleSignInServices
                          .googleSignInServices
                          .signWithGoogle();

                      User? user = GoogleSignInServices.googleSignInServices
                          .currentUser();

                      Map m1 = {
                        'name': user!.displayName,
                        'email': user.email,
                        'photoUrl': user.photoURL,
                        'userToken': await FirebaseMessagingServices.firebaseMessagingServices.generateDeviceToken(),
                        'phone':user.phoneNumber ?? "No Number",
                      };
                      UserModel userModel = UserModel.fromMap(m1);
                      await UserServices.userServices.addUser(userModel);

                      Fluttertoast.showToast(msg: status);
                      if (status == 'Success') {
                        Get.to(const HomeScreen());
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 250, top: 12),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            GestureDetector(
              onTap: () {
                controller.signIn(controller.txtEmail.text, controller.txtPassword.text);
                controller.txtEmail.clear();
                controller.txtPassword.clear();
              },
              child: Container(
                height: screenHeight * 0.07,
                width: screenWidth * 0.85,
                decoration: BoxDecoration(
                    color: Color(0xff7c01f6),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.18),
              child: Row(
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize:
                          screenWidth * 0.04, // Adjusted for better visibility
                    ),
                  ),
                  GestureDetector(
                    onTap: () {

                      Get.to(SignupScreen());
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7c01f6),
                        fontSize: screenWidth *
                            0.045, // Adjusted for better visibility
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
