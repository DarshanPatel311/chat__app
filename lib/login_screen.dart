
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controlar/Login_getx.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController=Get.put(LoginController());
    return Scaffold(
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Let's Sign you in.",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30
            ), ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Welcome back \nYou've been missed!",style: TextStyle(
              color: Colors.grey,
              fontSize: 22,
              fontWeight: FontWeight.w400
            ),),
          ),
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(" Username or Email",style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),),
                TextField(
                  controller: loginController.txtEmail,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),

                      )
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(" Password",style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),),
                TextField(
                  controller: loginController.txtPassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),

                      )
                  ),
                )
              ],
            ),
          ),
          Center(child: Text("-------------------------- or -------------------------- ",style: TextStyle(
              color: Colors.grey,
            fontWeight: FontWeight.bold
          ),)),
         SizedBox(height: 30,),
          Center(
            child: Container(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(


                      borderRadius: BorderRadius.circular(10),

                    ),
                    child:  Image.asset('assets/img/Google__G__logo.svg.png',)),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(

                      image: DecorationImage(
                          image: AssetImage("assets/img/linkedin.png")),
                      borderRadius: BorderRadius.circular(10),

                    ),),

                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(


                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("assets/img/facebook.webp")
                      ),
                    ),
                    ),

                ],
              ),
            ),
          ),
           Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account ?",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),),
              Text(" Register",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
            ],
          ),
          SizedBox(height: 5,),
          Center(
            child: InkWell(
              onTap: () {
                loginController.SignUp(loginController.txtEmail.text, loginController.txtPassword.text);

              },
              child: Container(
                height: 70,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),

                ),
                child: Center(child: Text("Sign Up",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white
                ),),),
              ),
            ),
          ),

          SizedBox(height: 50,),

        ],
      ),

    );
  }
}
