// ignore_for_file:  use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unloack/screens/home_page.dart';
import 'package:unloack/widgets/alert.dart';
import '../../../screens/admin/firebase_admin/firebase_add.dart';
import '../../../screens/login_screen.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerWithEmailAndPassword(
      String email, String password, String name, BuildContext context) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      addUserToCollection(
        userId: userCredential.user!.uid,
        email: email,
        name: name,
      );
      //addUserToCollection(email, password, userCredential.user!.uid);
      // User? currentUser = _auth.currentUser;

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
      //}
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 10,
            child: const Center(
                child: Text(
              'Week Password',
              style: TextStyle(color: Colors.red),
            )),
          ),
          duration: const Duration(seconds: 1),
          elevation: 100,
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 10,
            child: const Center(
                child: Text(
              'Mail id already exists try another',
              style: TextStyle(color: Colors.red),
            )),
          ),
          duration: const Duration(seconds: 2),
          elevation: 100,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height / 10,
          child: const Center(
              child: Text(
            'Something went wrong',
            style: TextStyle(color: Colors.red),
          )),
        ),
        duration: const Duration(seconds: 2),
        elevation: 100,
      ));
    }
  }

  //////////////////////////////////////////////////////////////////
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  //////////////////////////////////////////////////////////////////
  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context, bool admin) async {
    // await _auth.signInWithEmailAndPassword(email: email, password: password);
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (!admin) {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertBox(
            firstButtonIconData: Icons.admin_panel_settings_outlined,
            firstButtonColor: Colors.green,
            firstButtonIconColor: Colors.green,
            firstButtonOnPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FirebaseAdd()),
              );
            },
            firstButtonText: 'Admin',
            secondButtonIconData: Icons.supervised_user_circle,
            secondButtonOnPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            secondButtonText: 'User',
            message: 'You have admin access\nHow would you like to continue?',
            title: 'Admin',
            titleColor: Colors.green,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 10,
            child: const Center(
                child: Text(
              'User not found',
              style: TextStyle(color: Colors.red),
            )),
          ),
          duration: const Duration(seconds: 1),
          elevation: 100,
        ));
      } else if (e.code == 'RecaptchaAction') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 10,
            child: const Center(
                child: Text(
              'Wrong Password',
              style: TextStyle(color: Colors.red),
            )),
          ),
          duration: const Duration(seconds: 1),
          elevation: 100,
        ));
      }
      ///////////
      else if (e.code == 'network-request-failed') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 10,
            child: const Center(
                child: Text(
              'Network Error',
              style: TextStyle(color: Colors.red),
            )),
          ),
          duration: const Duration(seconds: 1),
          elevation: 100,
        ));
      }
    }
    //////////

    /////////
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height / 10,
          child: Center(
              child: Text(
            'Something went wrong $e',
            style: const TextStyle(color: Colors.red),
          )),
        ),
        duration: const Duration(seconds: 1),
        elevation: 100,
      ));
    }
  }

  Future<void> addUserToCollection(
      {required String userId,
      required String email,
      required String name}) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({'Id': userId, 'email': email, 'name': name});
    } catch (e) {
      //Something went wrong
    }
  }
}
