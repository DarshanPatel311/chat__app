import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseSarvice {
  static FirebaseSarvice firebaseSarvice=FirebaseSarvice._();
  FirebaseSarvice._();
  FirebaseAuth auth=FirebaseAuth.instance;
  Future<void> SignUpAccount(String email,String password) async {
   UserCredential userCredential= await auth.createUserWithEmailAndPassword(email: email, password: password);
  }



}