import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:unloack/screens/getstarted_screen.dart';

//import 'package:unloack/screens/login_screen.dart';

signOut(BuildContext context) async {
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sharedPreferences.clear();
  FirebaseAuth.instance.signOut();

  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const GetStarted(),
      ),
      (route) => false);
  // SystemNavigator.pop();
}
