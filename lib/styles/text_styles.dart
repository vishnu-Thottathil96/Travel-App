import 'package:flutter/material.dart';

const mainHeadingStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);
const subHeadingStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
const subHeadingNormal =
    TextStyle(fontSize: 15, color: Color.fromARGB(255, 102, 102, 102));
final personalisedlistText = TextStyle(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.w500,
  shadows: [
    Shadow(
      color: Colors.black.withOpacity(0.5),
      offset: const Offset(1, 1),
      blurRadius: 3,
    ),
  ],
);
const mainHeadingStyleWhite =
    TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white);
const subHeadingStyleWhite =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
