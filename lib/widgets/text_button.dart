import 'package:evently/utils/evently_colors.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget{
  void Function()? onPressed;
  String text;
  TextStyle? textStyle;

  CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: WidgetStatePropertyAll(EventlyColors.transparent)
        ),
        child: Text(
          text,
          style: textStyle
        ),
    );
  }

}