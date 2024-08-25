import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  static ChatServices chatServices = ChatServices._();

  ChatServices._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> insertData(
      Map<String, dynamic> chat, String sender, String receiver) async {
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("-");
    await firestore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .add(chat);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getData(
      String sender, String receiver) {
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("-");
    return firestore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<void> updateChat(
      {required String chatid,
      required String sender,
      required String receiver,
      required String message}) async {
    List doc = [sender, receiver];
    doc.sort();
    String docid = doc.join('-');
    await FirebaseFirestore.instance
        .collection('chatroom')
        .doc(docid)
        .collection('chat')
        .doc(chatid)
        .update({'message': message});
  }
}
