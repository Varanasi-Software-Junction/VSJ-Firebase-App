import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VsjGoogleSignIn {
  //********************Define the google sign in object
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

//********************Define the google sign in object
  static Future<String> doSignIn() async
  {
    try {
      final GoogleSignInAccount googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    }
    on FirebaseAuthException catch (ex) {
      print(ex.message);
      throw ex;
    }
  }

  static Future<void> doSignOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (ex) {
      print(ex);
    }
  }

  static User getUser() {
    User user = _auth.currentUser;
    return user;
  }

}