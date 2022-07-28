import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.buttonColor,
    required this.circular,
    required this.onPressed,
    required this.verticalPadding,
    this.size,
    this.borderColor = Colors.transparent,
  }) : super(key: key);
  final String text;
  final Color textColor;
  final Color buttonColor;
  final double circular;
  final VoidCallback onPressed;
  final double verticalPadding;
  final Color borderColor;
  final Size? size;

// final double? height;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      style: ElevatedButton.styleFrom(
        minimumSize: size,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
        ),
        side: BorderSide(
          color: borderColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circular),
        ),
        elevation: 0,
        primary: buttonColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}
