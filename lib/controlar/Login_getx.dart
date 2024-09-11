import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../firebase_sarvis/firebase.dart';

class LoginController extends GetxController {


  TextEditingController txtEmail=TextEditingController();
  TextEditingController txtPassword=TextEditingController();


  Future<void> SignUp(String email,String password) async {
   await FirebaseSarvice.firebaseSarvice.SignUpAccount(email, password);



  }


}