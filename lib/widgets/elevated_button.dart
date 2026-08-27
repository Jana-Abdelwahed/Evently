import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/evently_colors.dart';
import 'package:evently/utils/evently_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../utils/dimensions.dart';

class CustomElevatedButton extends StatelessWidget{
  void Function()? onButtonClick;
  PageController? controller;
  String title;
  TextStyle? textStyle;
  int index;
  bool isLogo;
  bool isBorder;
  Color? buttonColor;

  CustomElevatedButton({
    super.key,
    this.controller,
    required this.title,
    this.index = 0,
    this.isLogo = false,
    required this.textStyle,
    required this.onButtonClick,
    required this.buttonColor,
    this.isBorder = false
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = context.width;
    var height = context.height;

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height*0.01
      ),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(buttonColor),
              overlayColor: WidgetStatePropertyAll(buttonColor),
              shadowColor: WidgetStatePropertyAll(EventlyColors.transparent),
              shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    side: isBorder
                        ? BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1.5
                    )
                        : BorderSide(
                      color: EventlyColors.transparent
                    )
                  )
              )
          ),
          onPressed: onButtonClick,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: height*0.015,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: isLogo,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: width * 0.04
                        ),
                        child: FaIcon(
                        FontAwesomeIcons.google,
                          color:
                          themeProvider.isDark
                              ? EventlyColors.lightBlue
                              : EventlyColors.mainBlue,
                          size: 24,
                        ),
                      ),
                    ),
                Text(
                  title,
                  style: textStyle,
                ),
              ],
            ),
          )
      ),
    );
  }
}