import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../Controller/login.dart';
import '../firebase_sarvice/chat.dart';
import '../firebase_sarvice/firebase_notificton/ApiService.dart';
import '../firebase_sarvice/google_services.dart';
import '../model/Chat.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SignInController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1f1f1f),
        title: Obx(() => Text(
              controller.receiverName.value,
              style: TextStyle(color: Colors.white),
            )),
        actions: [
          Icon(Icons.call,size: 30,),
          SizedBox(width: 20,),
          Icon(Icons.camera_alt_rounded,size: 30,),
          SizedBox(width: 20,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: ChatServices.chatServices.getData(
                    GoogleSignInServices.googleSignInServices
                        .currentUser()!
                        .email!,
                    controller.receiverEmail.value),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  var queryData = snapshot.data!.docs;
                  List chats = queryData.map((e) => e.data()).toList();

                  List chatid = queryData.map((e) => e.id).toList();
                  print('------------$chatid');
                  List<Chat> chatList = [];

                  for (var chat in chats) {
                    chatList.add(Chat.fromMap(chat));
                  }

                  return Container(
                    width: double.infinity,
                    // color: Colors.grey.shade100,
                    child: Column(
                      children: List.generate(chatList.length, (index) {
                        return Align(
                            alignment: (chatList[index].sender ==
                                    GoogleSignInServices.googleSignInServices
                                        .currentUser()!
                                        .email!)
                                ? Alignment.centerRight
                                : Alignment.centerLeft,


                            child: GestureDetector(
                                onLongPress: () {
                                  controller.txtEdit = TextEditingController(
                                      text: chatList[index].message);
                                  if (chatList[index].sender ==
                                      GoogleSignInServices.googleSignInServices
                                          .currentUser()!
                                          .email) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Edit'),
                                          content: TextField(
                                            controller: controller.txtEdit,
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  ChatServices.chatServices
                                                      .updateChat(
                                                          chatid: chatid[index],
                                                          sender: GoogleSignInServices.googleSignInServices.currentUser()!.email!,
                                                          receiver: controller
                                                              .receiverEmail
                                                              .value,
                                                          message: controller
                                                              .txtEdit.text);
                                                  Get.back();
                                                },
                                                child: Text('Edit')),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },

                                child: Card(
                                  color: Colors.grey.shade500,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      chatList[index].message!,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                )));
                      }),
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: controller.txtMsg,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                suffixIcon: IconButton(
                    onPressed: () async {
                      Map<String, dynamic> chat = {
                        'sender': GoogleSignInServices.googleSignInServices
                            .currentUser()!
                            .email,
                        'receiver': controller.receiverEmail.value,
                        'message': controller.txtMsg.text,
                        'timestamp': DateTime.now(),
                      };
                      await ChatServices.chatServices.insertData(
                          chat,
                          GoogleSignInServices.googleSignInServices
                              .currentUser()!
                              .email!,
                          controller.receiverEmail.value);

                      await ApiService.apiService.sendMessage(
                          controller.receiverEmail.value,
                          controller.txtMsg.text,
                          controller.receivertoken.value,
                        // controller.currentLogin.value,
                        // controller.txtChats.text,
                        // controller.,
                      );
                      controller.txtMsg.clear();
                    },
                    icon: const Icon(Icons.send)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
