import 'package:chat_box/firebase_sarvice/firebase_notificton/FirebaseMessagingServices.dart';
import 'package:chat_box/view/LogIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../Controller/login.dart';
import '../firebase_sarvice/User.dart';
import '../firebase_sarvice/google_services.dart';
import '../model/data_model.dart';
import 'home_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller =Get.put(SignInController());

    // Use MediaQuery to get the height and width of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.05, // 5% of screen height
              width: double.infinity,
            ),
            Container(
              height: screenHeight * 0.35, // 35% of screen height
              width: screenWidth * 0.8, // 80% of screen width
              child: Image.asset('assets/img/signUp.png'),
            ),
            Text(
              "Sign Up",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.09, // Font size based on screen width
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
                controller: controller.txtName,
                decoration: InputDecoration(
                    label: Text(
                      "Username",
                      style: TextStyle(color: Colors.white),
                    ),
                    prefixIcon: Icon(
                      Icons.perm_identity_sharp,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            Container(
              height: screenHeight * 0.06,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white12,
              ),
              child: TextField(
                controller: controller.txtEmail,
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
              height: screenHeight * 0.02,
            ),
            Container(
              height: screenHeight * 0.06,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white12,
              ),
              child: TextField(
                controller: controller.txtPassword,
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
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Stack(
              children: [
                Container(

                    height: 80,
                    width: 350,
                    child: Image.asset('assets/img/Social media-uihut@3x.png')),
                Padding(
                  padding: const EdgeInsets.only(left: 50,top: 12),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 150,top: 12),
                  child: GestureDetector(
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
                      color: Colors.yellow,


                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 250,top: 12),
                  child: GestureDetector(
                    onTap: () {

                    },
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
              onTap: () async {
                Map m1 = {
                  'name' : controller.txtName.text,
                  'email' : controller.txtEmail.text,
                  'phone' : controller.txtPhone.text,
                  'photoUrl' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRs0zRErHVtCItlgm9u-Z0gRWsTvb7dHgDBonhTmQfY65Y6giXYee-uwCYa8n7hzazP8vE&usqp=CAU',
                  'userToken': await FirebaseMessagingServices.firebaseMessagingServices.generateDeviceToken(),
                };
                UserModel userModel = UserModel.fromMap(m1);
                await UserServices.userServices.addUser(userModel);
                await controller.signup(controller.txtEmail.text, controller.txtPassword.text);
                controller.txtEmail.clear();
                controller.txtPassword.clear();
                controller.txtName.clear();

              },
              child: Container(
                height: screenHeight * 0.07,
                width: screenWidth * 0.85,
                decoration: BoxDecoration(
                    color: Color(0xff7c01f6),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    "Sign Up",
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
              padding: EdgeInsets.only(left: screenWidth * 0.21),
              child: Row(
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                        fontSize: screenWidth * 0.04,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(LoginScreen());
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7c01f6),
                        fontSize: screenWidth * 0.045,
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
