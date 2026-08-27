import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/dimensions.dart';
import 'package:evently/utils/evently_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef Validator = String? Function(String?)?;

class CustomTextFormField extends StatefulWidget {
  Widget prefixIcon;
  String hintText;
  bool isSuffixIcon;
  TextInputType? keyboardType;
  Validator validator;
  bool obscureText;
  TextEditingController? controller;

  CustomTextFormField({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    this.isSuffixIcon = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscureText = false,
    this.controller,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool showPassword;

  @override
  void initState() {
    super.initState();
    showPassword = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var height = context.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodySmall,
        cursorColor: EventlyColors.mainBlue,
        cursorHeight: height * 0.03,
        textInputAction: TextInputAction.next,
        keyboardType: widget.keyboardType,
        autocorrect: false,
        validator: widget.validator,
        obscureText: showPassword,
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          filled: true,
          prefixIcon: widget.prefixIcon,
          prefixIconColor: EventlyColors.greyDisable,
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          hoverColor: themeProvider.isDark
              ? Theme.of(context).primaryColor
              : EventlyColors.white,
          focusColor: themeProvider.isDark
              ? Theme.of(context).primaryColor
              : EventlyColors.white,
          border: buildOutlineInputBorder(themeProvider),
          enabledBorder: buildOutlineInputBorder(themeProvider),
          focusedBorder: buildOutlineInputBorder(themeProvider),
          errorBorder: buildOutlineInputBorder(themeProvider),
          disabledBorder: buildOutlineInputBorder(themeProvider),
          fillColor: themeProvider.isDark
              ? Theme.of(context).cardColor
              : EventlyColors.white,
          suffixIcon: widget.isSuffixIcon
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  highlightColor: EventlyColors.transparent,
                  icon: !showPassword
                      ? Icon(Icons.remove_red_eye_outlined)
                      : Icon(Icons.remove_red_eye_rounded),
                )
              : SizedBox(),
          suffixIconColor: EventlyColors.greyDisable,
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(dynamic themeProvider) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: themeProvider.isDark
            ? Theme.of(context).dividerColor
            : Theme.of(context).dividerColor,
        width: 1,
      ),
    );
  }
}
