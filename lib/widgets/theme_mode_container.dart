import 'package:evently/cache/cache_helper.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../utils/dimensions.dart';
import '../utils/evently_colors.dart';
import '../utils/evently_theme.dart';

class CustomThemeModeContainer extends StatefulWidget{
  String icon;
  ThemeMode themeMode;

  CustomThemeModeContainer({
    super.key,
    required this.icon,
    required this.themeMode,
  });

  @override
  State<CustomThemeModeContainer> createState() => _CustomThemeModeContainerState();
}

class _CustomThemeModeContainerState extends State<CustomThemeModeContainer> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    bool isSelected = themeProvider.appTheme == widget.themeMode;
    var width = context.width;
    var height = context.height;
    return InkWell(
      overlayColor: WidgetStatePropertyAll(EventlyColors.transparent),
      onTap: () async {
          themeProvider.changeTheme(widget.themeMode);
         await CacheHelper.setData(key: "theme_selected", value: widget.themeMode.name);
          setState(() {

          });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height*0.01
        ),
        decoration:
        themeProvider.isDark
        ? BoxDecoration(
          color: isSelected ?
          Theme.of(context).primaryColor :
          Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
            border: BoxBorder.all(
                color: EventlyTheme.darkTheme.dividerColor,
                width: 1.5
            )
        ):
        BoxDecoration(
          color: isSelected ?
          EventlyColors.mainBlue :
          EventlyColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child:
        SvgPicture.asset(
          widget.icon,
          colorFilter:
          isSelected ?
          ColorFilter.mode(EventlyColors.white, BlendMode.srcIn) :
          ColorFilter.mode(
              themeProvider.isDark
              ? EventlyColors.white
              : EventlyColors.mainBlue,
              BlendMode.srcIn),
        )
      ),
    );
  }
}