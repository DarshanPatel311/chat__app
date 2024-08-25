import 'package:chat_box/firebase_sarvice/User.dart';
import 'package:chat_box/view/signUp.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../Controller/login.dart';
import '../firebase_sarvice/google_services.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(SignInController());
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
        child: FutureBuilder(
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
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: 70),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        NetworkImage(currentUser['photoUrl'] ?? ''),
                  ),
                ),
                 SizedBox(
                  height: 20,
                ),
                Text(
                  currentUser['name']??"",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(currentUser['email']??""),
              ],
            );
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Messages",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
            color: Colors.white54,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.emailLogOut();
              Fluttertoast.showToast(
                msg: "Logged out successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16,
              );
              Get.off(() => SignupScreen());
            },
            icon: Icon(Icons.logout, size: 30, color: Color(0xff4d4c4e)),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 60,
              width: 400,
              decoration: BoxDecoration(
                  color: Color(0xff121111),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Search...",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4d4c4e)),
                  ),
                  Spacer(),
                  Icon(
                    Icons.search,
                    size: 35,
                    color: Color(0xff4d4c4e),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding:  EdgeInsets.only(left: 10),
            child: Container(
              height: 35,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Currently Active  ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white54),
                  ),
                  Icon(
                    Icons.circle,
                    size: 16,
                    color: Colors.green.shade700,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(width: 5,),

              Expanded(
                child: StreamBuilder(
                  stream: UserServices.userServices.getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      List userList = snapshot.data!.docs
                          .map(
                            (e) => e.data(),
                      )
                          .toList();

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(

                          children: [

                            ...List.generate(userList.length,(index)=>Row(
                              children: [
                                SizedBox(width: 10,),
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(userList[index]['photoUrl']),),
                              ],
                            ) ),

                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('No users found.'),
                      );
                    }
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding:  EdgeInsets.only(left: 21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Chats  ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white54),
                ),
                Spacer(),

                Icon(
                  Icons.more_horiz_outlined,
                  size: 25,
                  color: Colors.white54,
                ),
                SizedBox(width: 20,),
              ],
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Expanded(
            child: StreamBuilder(
              stream: UserServices.userServices.getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  List userList = snapshot.data!.docs
                      .map(
                        (e) => e.data(),
                      )
                      .toList();


                  return Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        var user = userList[index];
                        return GestureDetector(
                          onTap: () {
                            controller.getReceiver(userList[index]['email'], userList[index]['name'],userList[index]['userToken']);
                            Get.to(const ChatScreen());
                          },
                          // child: Container(
                          //   height: 70,
                          //   margin: EdgeInsets.only(left: 20,right: 10,bottom: 10),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(15),
                          //     border: Border.all(color: Colors.white54,width: 1.4),
                          //
                          //   ),
                          //   child: Row(
                          //     children: [
                          //       SizedBox(width: 10,),
                          //     CircleAvatar(
                          //
                          //         backgroundImage: NetworkImage(user['photoUrl']),
                          //       radius: 25,
                          //       ),
                          //       SizedBox(width: 20,),
                          //       Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Text(user['name'],style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 17
                          //           ),),
                          //           Text(user['email']),
                          //         ],
                          //       ),
                          //       Spacer(),
                          //       CircleAvatar(
                          //         radius: 10,
                          //         child: Text("4",style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 13
                          //         ),),
                          //       ),
                          //       SizedBox(width: 20,),
                          //     ],
                          //   ),
                          // ),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 23,
                              backgroundImage: NetworkImage(user['photoUrl']),
                            ),
                            title: Text(user['name']),
                            subtitle: Text(user['email']),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('No users found.'),
                  );
                }
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.only(left: 30, right: 30),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Color(0xff121111),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.chat_outlined,
                size: 40,
                color: Color(0xff7c01f6),
              ),
              Icon(
                Icons.call,
                size: 40,
                color: Color(0xff4d4c4e),
              ),
              Icon(
                Icons.photo_camera_rounded,
                size: 40,
                color: Color(0xff4d4c4e),
              ),
              Icon(
                Icons.settings,
                size: 40,
                color: Color(0xff4d4c4e),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
