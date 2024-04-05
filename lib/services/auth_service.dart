import 'dart:developer';

import 'package:alindor_tech/configs/error_handler.dart';
import 'package:alindor_tech/screens/chat/in_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // A function that signs in a user with Google authentication. Takes in a context parameter. Returns a User object if sign-in is successful, otherwise returns null.
  Future<User?> signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (_) => const ChatScreen()),
            (route) => false);
        log(userCredential.user.toString());
        return userCredential.user;
      }
    } catch (e) {
      log('Error signing in with Google: $e');
      openTopSnackBar(context, 'Error signing in with Google');
    }
    return null;
  }
}
