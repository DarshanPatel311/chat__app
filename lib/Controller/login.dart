import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../firebase_sarvice/google_services.dart';
import '../firebase_sarvice/signUp.dart';

import '../view/home_screen.dart';

class SignInController extends GetxController {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtMsg = TextEditingController();
  TextEditingController txtEdit = TextEditingController();

  RxString email = ''.obs;
  RxString name = ''.obs;
  RxString url = ''.obs;
  RxString receiverEmail = "".obs;
  RxString receiverName = "".obs;
  RxString receivertoken = "".obs;

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }

  void getReceiver(String email, String name,String userToken){
    receiverEmail.value = email;
    receiverName.value = name;
    receivertoken.value = userToken;
  }

  void getName(){
   receiverName.value=name as String;
   print(receiverName);
   print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  }

  void getUserDetails(){
    User? user = GoogleSignInServices.googleSignInServices.currentUser();
    if (user != null) {
      email.value = user.email!;
      // name.value = user.displayName!;
      // url.value = user.photoURL!;
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      bool emails = await AuthServices.authServices.checkEmail(email);
      if (emails) {

        Get.snackbar('Sign Up Failed',
          'Email already in use. Please use a different email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black12,
          colorText: Colors.white,
        );

      }
      else{
        String response = await AuthServices.authServices.createAccount(email, password);
        Get.snackbar('Sign Up', 'Sign Up Successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black12,
          colorText: Colors.white,

        );
        if(response=="success")
          {
            Get.to( HomeScreen());
          }
      }

    }catch(e)
    {
      Get.snackbar('Sign Up Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black12,
        colorText: Colors.white,
      );
    }
  }
  Future<void> signIn(String email,String password)
  async {
    try{
      User? user = await AuthServices.authServices.Signin(email, password);
      if(user!=null)
      {
        Get.to( HomeScreen());
      }
      else{
        Get.snackbar('Login Failed', 'Incorrect email or password.',
          snackPosition: SnackPosition.BOTTOM,

        );
      }
    }catch(e){
      Get.snackbar('Login Failed', e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black12,
        colorText: Colors.white,
      );
    }
  }

  void emailLogOut(){
    AuthServices.authServices.signout();
    GoogleSignInServices.googleSignInServices.emailLogOut();
  }
}