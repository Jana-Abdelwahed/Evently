import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/dimensions.dart';
import 'package:evently/utils/evently_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TabWidget extends StatelessWidget{
  final String eventName;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final Color iconSelectedColor;
  final Color iconUnSelectedColor;
  final FaIconData? icon;
   TabWidget({
     super.key,
     required this.eventName,
     required this.isSelected,
     required this.selectedColor,
     required this.unselectedColor,
     required this.iconSelectedColor,
     required this.iconUnSelectedColor,
     required this.icon
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = context.width;
    var height = context.height;
   return Container(
     padding: EdgeInsetsGeometry.symmetric(
       horizontal: width * 0.04,
       vertical: height * 0.01,
     ),
     decoration: BoxDecoration(
       color:
       isSelected
           ? selectedColor
           : unselectedColor,
       borderRadius: BorderRadius.circular(16),
       border: BoxBorder.all(
         color: Theme.of(context).dividerColor,
         width: 1
       )
     ),
     child: Row(
       spacing: width * 0.02,
       children: [
         FaIcon(
           icon,
           size: 20,
           color: isSelected
               ? iconSelectedColor
               : iconUnSelectedColor
         ),
         Text(
           eventName,
           style:
           isSelected || themeProvider.isDark ?
           Theme.of(context).textTheme.headlineLarge
               : Theme.of(context).textTheme.headlineMedium,
         ),
       ],
     ),
   );
  }

}