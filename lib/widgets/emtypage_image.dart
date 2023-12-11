import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  EmptyPage(
      {Key? key, required this.displayText, required this.displayTextColor});
  final String displayText;
  final Color displayTextColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Image.asset('assets/images/emptypage.png'),
          Positioned.fill(
            child: Center(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  displayText,
                  style: TextStyle(fontSize: 25, color: displayTextColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
