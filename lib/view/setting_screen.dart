import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase_sarvice/User.dart';
import '../firebase_sarvice/google_services.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),

      ),
      body: FutureBuilder(
        future: UserServices.userServices.getCurrentUser(
            GoogleSignInServices.googleSignInServices.currentUser()!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading_________________________________");
          }

          Map<String, dynamic> currentUser =
          snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(),

              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                  NetworkImage(currentUser['photoUrl'] ?? ''),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  currentUser['name']??"",
                  style: const TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 23),
                ),
              ),
              Center(
                child: Text(currentUser['email']??"",style: TextStyle(
                  fontSize: 16
                ),),
              ),
              Center(
                child: Text(currentUser['phone']??"+91 000 154 456",style: TextStyle(
                  fontSize: 16
                ),),
              ),

              SizedBox(height: 20,),
              Center(
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xff7c01f6)
                  ),
                  child: Center(child: Text("Edit Profile",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),),),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    CircleAvatar(

                      child: Icon(Icons.nightlight_rounded),
                    ),
                    SizedBox(width: 20,),
                    Text("Night Mode",style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),),
                    Spacer(),
                    Switch(value: false, onChanged: (value) {

                    },)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    CircleAvatar(

                      child: Icon(Icons.notification_add_outlined),
                    ),
                    SizedBox(width: 20,),
                    Text("Night Mode",style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),),
                    Spacer(),
                    Switch(value: false, onChanged: (value) {

                    },)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    CircleAvatar(

                      child: Icon(Icons.security),
                    ),
                    SizedBox(width: 20,),
                    Text("Private Account",style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),),
                    Spacer(),
                    Switch(value: false, onChanged: (value) {

                    },)
                  ],
                ),
              ),

            ],
          );
        },
      ),

    );
  }
}
