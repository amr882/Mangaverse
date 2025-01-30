import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mangaverse/auth/view/lets_you_in.dart';
import 'package:mangaverse/auth/view/email_verification.dart';

class AuthServer {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static User? currentUser = auth.currentUser;
  // create account

  static Future createUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const EmailVerification()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // sign in

  static Future signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      // User credentials
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // email verification

  static Future sendEmailVerification() async {
    try {
      await currentUser!.sendEmailVerification();
      print('Verification email sent');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found. Please create an account.');
      } else if (e.code == 'invalid-email') {
        print('Invalid email address.');
      } else {
        print(e.message);
      }
    }
  }

  // google sign in

  //
  static Future<void> signOut(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LetsYouIn()));
  }
}
