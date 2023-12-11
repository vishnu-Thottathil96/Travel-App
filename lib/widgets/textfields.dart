import 'package:flutter/material.dart';

class TextForm extends StatefulWidget {
  const TextForm(
      {Key? key,
      this.keyType,
      this.maximumLength,
      this.initialMessage,
      required this.hintTextToDisplay,
      required this.onSavedCallback,
      required this.validatorMessage,
      this.obscureText = false})
      : super(key: key);

  final TextInputType? keyType;
  final int? maximumLength;
  final String hintTextToDisplay;
  final void Function(String?) onSavedCallback;
  final String validatorMessage;
  final String? initialMessage;
  final bool obscureText;

  @override
  // ignore: library_private_types_in_public_api
  _TextFormState createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  late String? value;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      keyboardType: widget.keyType,
      maxLength: widget.maximumLength,
      decoration: InputDecoration(
        hintText: widget.hintTextToDisplay,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.validatorMessage;
        }
        return null;
      },
      initialValue: widget.initialMessage,
      onSaved: (newValue) {
        value = newValue;
        widget.onSavedCallback(newValue);
      },
    );
  }
}
