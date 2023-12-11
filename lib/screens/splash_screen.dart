// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:unloack/screens/getstarted_screen.dart';
import 'package:unloack/screens/home_page.dart';

import '../db/firebase/firebase_crud.dart';

class Splash extends StatelessWidget {
  const Splash({super.key, required this.logedin});
  final bool logedin;

  checker(BuildContext context) async {
    if (!logedin) {
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const GetStarted(),
      ));
    } else {
      DestinationRepository().getRandomDestinations();
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomePage(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    checker(context);
    DestinationRepository().getRandomDestinations();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/splash travel.gif',
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }
}
