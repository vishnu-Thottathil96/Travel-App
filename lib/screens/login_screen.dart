import 'package:flutter/material.dart';
import 'package:unloack/widgets/sign_in_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Material(
                //elevation: 5,
                child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70.0),
                  bottomRight: Radius.circular(70.0),
                ),
              ),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/login logo.jpg',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width *
                    0.01, // Adjust the width as per your preference

                height: MediaQuery.of(context).size.height *
                    0.01, // Adjust the height as per your preference
              ),
            )),
            const SignInForm()
          ],
        ),
      )),
    );
  }
}
