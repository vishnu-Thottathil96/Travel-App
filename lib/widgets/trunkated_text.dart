import 'package:flutter/widgets.dart';

class TruncatedText extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextStyle textStyle;
  // ignore: use_key_in_widget_constructors
  const TruncatedText(this.text, this.textStyle, {this.maxLines = 1});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
