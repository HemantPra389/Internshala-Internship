import 'package:flutter/material.dart';

class UtilFun {
  static Text fredokaText(
    String text, {
    Color color = Colors.black,
    TextAlign textAlign = TextAlign.start,
    double size = 18,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
          fontFamily: 'Fredoka'),
    );
  }

  static vbox(double size) {
    return SizedBox(
      height: size,
    );
  }

  static hbox(double size) {
    return SizedBox(
      width: size,
    );
  }

  static showSnackbar(BuildContext context, String text,
      [bool isError = true]) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: UtilFun.fredokaText(text, color: Colors.white, size: 16),
      duration: const Duration(seconds: 2),
      backgroundColor:
          isError ? const ColorScheme.light().error : Colors.green.shade400,
    ));
  }
}
