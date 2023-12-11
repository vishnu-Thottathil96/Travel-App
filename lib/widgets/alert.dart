import 'package:flutter/material.dart';

class AlertBox extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback firstButtonOnPressed;
  final VoidCallback secondButtonOnPressed;
  final String firstButtonText;
  final String secondButtonText;
  final IconData firstButtonIconData;
  final IconData secondButtonIconData;
  final Color? firstButtonColor;
  final Color? secondButtonColor;
  final Color? firstButtonIconColor;
  final Color? secondButtonIconColor;
  final Color? messageColor;
  final Color? titleColor;
  final double? firstButtonFontSize;
  final double? secondButtonFontSize;

  const AlertBox({
    Key? key,
    required this.firstButtonIconData,
    required this.firstButtonOnPressed,
    required this.firstButtonText,
    required this.secondButtonIconData,
    required this.secondButtonOnPressed,
    required this.secondButtonText,
    required this.message,
    required this.title,
    this.firstButtonColor,
    this.secondButtonColor,
    this.firstButtonIconColor,
    this.secondButtonIconColor,
    this.messageColor,
    this.titleColor,
    this.firstButtonFontSize,
    this.secondButtonFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        message,
        style: TextStyle(color: messageColor),
      ),
      title: Text(
        title,
        style: TextStyle(color: titleColor),
      ),
      actions: [
        TextButton.icon(
          onPressed: firstButtonOnPressed,
          icon: Icon(firstButtonIconData, color: firstButtonIconColor),
          label: Text(
            firstButtonText,
            style: TextStyle(
              color: firstButtonColor,
              fontSize: firstButtonFontSize,
            ),
          ),
        ),
        TextButton.icon(
          onPressed: secondButtonOnPressed,
          icon: Icon(secondButtonIconData, color: secondButtonIconColor),
          label: Text(
            secondButtonText,
            style: TextStyle(
              color: secondButtonColor,
              fontSize: secondButtonFontSize,
            ),
          ),
        ),
      ],
    );
  }
}
