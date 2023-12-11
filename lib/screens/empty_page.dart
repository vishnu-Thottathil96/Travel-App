import 'package:flutter/material.dart';

// ignore: camel_case_types
class Empty_Page extends StatelessWidget {
  const Empty_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Image.asset('assets/images/emptypage.png')),
    );
  }
}
