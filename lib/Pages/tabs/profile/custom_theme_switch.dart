import 'package:evently/cache/cache_helper.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/dimensions.dart';
import 'package:evently/utils/evently_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomThemeSwitch extends StatefulWidget {
  ThemeMode themeMode;

  CustomThemeSwitch({super.key, required this.themeMode});
  @override
  State<CustomThemeSwitch> createState() => _CustomThemeSwitchState();
}

class _CustomThemeSwitchState extends State<CustomThemeSwitch> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Switch(
      padding: EdgeInsetsGeometry.zero,
      focusColor: themeProvider.isDark
          ? Theme.of(context).primaryColor
          : Theme.of(context).dividerColor,
      hoverColor: themeProvider.isDark
          ? Theme.of(context).primaryColor
          : Theme.of(context).dividerColor,
      activeTrackColor: themeProvider.isDark
          ? Theme.of(context).primaryColor
          : Theme.of(context).dividerColor,
      trackOutlineColor: WidgetStatePropertyAll(EventlyColors.transparent),
      activeThumbColor: EventlyColors.white,
      inactiveThumbColor: EventlyColors.white,
      inactiveTrackColor: EventlyColors.grey.withAlpha(50),
      value: themeProvider.isDark ? switchValue = true : switchValue,
      onChanged: (value) async {
        switchValue = value;
        widget.themeMode = ThemeMode.dark;
        value == true
            ? themeProvider.changeTheme(ThemeMode.dark)
            : widget.themeMode = ThemeMode.light;
        themeProvider.changeTheme(ThemeMode.light);
        themeProvider.changeTheme(widget.themeMode);
        await CacheHelper.setData(
          key: "theme_selected",
          value: widget.themeMode.name,
        );
        setState(() {});
      },
    );
  }
}
