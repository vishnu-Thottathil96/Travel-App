import 'package:flutter/material.dart';
import 'package:unloack/admin_credentials.dart';
import 'package:unloack/screens/home_page.dart';

import 'package:unloack/styles/colors.dart';
import 'package:unloack/styles/space.dart';
import 'package:unloack/styles/text_styles.dart';
import 'package:unloack/widgets/textfields.dart';

import '../db/functions/firebase_functions.dart/auth.dart';
import '../screens/signup_page.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  bool isWaiting = false;
  late String email = '';
  late String password = '';

  handleSubmit() async {
    // if (!_formKey.currentState!.validate()) return;
    final mail = email;
    final pass = password;
    String adminPassword = AdminPassword().adminpassword;
    String adminMail = AdminPassword().adminmail;
    bool admin;
    if (mail == adminMail && pass == adminPassword) {
      admin = true;
    } else {
      admin = false;
    }

    await Auth().signInWithEmailAndPassword(mail, pass, context, admin);
    setState(() {
      currentUser = Auth().getCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextForm(
                  hintTextToDisplay: 'E-mail Id',
                  onSavedCallback: (value) {
                    email = value!;
                  },
                  validatorMessage: 'Enter E-mail',
                ),
                verticalSpace(40),
                TextForm(
                  obscureText: true,
                  hintTextToDisplay: 'Password',
                  onSavedCallback: (value) {
                    password = value!;
                  },
                  validatorMessage: 'Enter password',
                ),
                verticalSpace(40),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(screenWidth, screenHeight / 15),
                  ),
                  onPressed: isWaiting
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            setState(() {
                              isWaiting = true;
                            });

                            handleSubmit();

                            setState(() {
                              isWaiting = false;
                            });

                            _formKey.currentState!.reset();
                          }
                        },
                  icon: const Icon(Icons.login),
                  label: const Text(
                    'Login',
                    style: subHeadingStyleWhite,
                  ),
                ),
                verticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'New User ?',
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Signup(),
                              ));
                        },
                        child: const Text(
                          'Sign up',
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
