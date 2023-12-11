import 'package:flutter/material.dart';
import 'package:unloack/styles/colors.dart';
import 'package:unloack/styles/space.dart';
import '../db/functions/firebase_functions.dart/auth.dart';
import '../widgets/textfields.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier<bool>(false);
  late String email = '';
  late String password = '';
  late String confirmPassword = '';
  late String nameOfUser = '';
  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final mail = email;
    final pass = password;
    final confirm = confirmPassword;
    final name = nameOfUser;
    if (pass == confirm) {
      _isLoadingNotifier.value = true;
      await Auth().registerWithEmailAndPassword(mail, pass, name, context);
      await Future.delayed(const Duration(seconds: 2));
      _isLoadingNotifier.value = false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height / 10,
          child: const Center(
              child: Text(
            'Wrong password',
            style: TextStyle(color: Colors.red),
          )),
        ),
        duration: const Duration(seconds: 1),
        elevation: 100,
      ));
    }

    // _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Text('Sign Up'),
      //   backgroundColor: primaryBlue,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight / 3,
                width: double.infinity,
                child: Image.asset('assets/images/signup.jpg'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenHeight / 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextForm(
                        hintTextToDisplay: 'Name',
                        onSavedCallback: (value) {
                          nameOfUser = value!;
                        },
                        validatorMessage: 'Enter Name',
                      ),
                      verticalSpace(screenHeight / 25),
                      TextForm(
                        hintTextToDisplay: 'E-mail Id',
                        onSavedCallback: (value) {
                          email = value!;
                        },
                        validatorMessage: 'Enter E-mail',
                      ),
                      verticalSpace(screenHeight / 25),
                      TextForm(
                        obscureText: true,
                        hintTextToDisplay: 'Password',
                        onSavedCallback: (value) {
                          password = value!;
                        },
                        validatorMessage: 'Enter password',
                      ),
                      verticalSpace(screenHeight / 25),
                      TextForm(
                        obscureText: true,
                        hintTextToDisplay: 'Confirm Password',
                        onSavedCallback: (value) {
                          confirmPassword = value!;
                        },
                        validatorMessage: 'Enter password',
                      ),
                      verticalSpace(screenHeight / 25),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: Size(screenWidth, screenHeight / 15),
                        ),
                        onPressed: _isLoadingNotifier.value
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  handleSubmit();
                                  _formKey.currentState!.reset();
                                }
                              },
                        icon: ValueListenableBuilder<bool>(
                          valueListenable: _isLoadingNotifier,
                          builder: (context, isLoading, child) {
                            return isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : const Icon(Icons.arrow_circle_right_outlined);
                          },
                        ),
                        label: _isLoadingNotifier.value
                            ? const SizedBox.shrink()
                            : const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
