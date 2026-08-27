import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/dimensions.dart';
import 'package:evently/utils/evently_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef OnChanged = void Function(String)?;
typedef Validator = String? Function(String?)?;

class SearchFormField extends StatefulWidget {
  final bool isSuffix;
  final String hintText;
  final int maxLines;
  TextEditingController? controller;
  Validator validator;
  OnChanged onChanged;
  TextInputType? keyboardType;
  SearchFormField({
    super.key,
    this.isSuffix = false,
    required this.hintText,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.controller,
  });

  @override
  State<SearchFormField> createState() => _SearchFormFieldState();
}

class _SearchFormFieldState extends State<SearchFormField> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var height = context.height;
    return TextFormField(
      maxLines: widget.maxLines,
      style: Theme.of(context).textTheme.bodySmall,
      cursorColor: EventlyColors.mainBlue,
      cursorHeight: height * 0.03,
      textInputAction: TextInputAction.next,
      keyboardType: widget.keyboardType,
      autocorrect: false,
      validator: widget.validator,
      onChanged: widget.onChanged,
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
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
        suffixIcon: widget.isSuffix ? Icon(Icons.search_rounded) : SizedBox(),
        suffixIconColor: Theme.of(context).primaryColor,
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
