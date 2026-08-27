import 'dart:io';

import 'package:evently/Localization/app_localizations.dart';
import 'package:evently/Pages/tabs/profile/custom_container_button.dart';
import 'package:evently/Pages/tabs/profile/custom_dropdown_menu.dart';
import 'package:evently/Pages/tabs/profile/custom_theme_switch.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/dimensions.dart';
import 'package:evently/utils/evently_colors.dart';
import 'package:evently/utils/evently_images.dart';
import 'package:evently/utils/evently_routes.dart';
import 'package:evently/utils/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    var width = context.width;
    var height = context.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.03,
      ),
      child: SafeArea(
        child: Column(
          children: [
            InkWell(
              highlightColor: EventlyColors.transparent,
              overlayColor: WidgetStatePropertyAll(EventlyColors.transparent),
              onTap: () async {
                File? temp = await PickImage.galleryPicker();
                if (temp != null) {
                  pickedImage = temp;
                }
                setState(() {});
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundImage: pickedImage == null
                        ? AssetImage(EventlyImages.route)
                        : FileImage(pickedImage!),
                    minRadius: height * 0.02,
                    maxRadius: height * 0.08,
                  ),
                  Container(
                    padding: EdgeInsets.all(width * 0.03),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeProvider.isDark
                          ? EventlyColors.darkBlue
                          : EventlyColors.whiteBg,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.image,
                      color: themeProvider.isDark
                          ? EventlyColors.white
                          : EventlyColors.mainBlue,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: height * 0.02,
                bottom: height * 0.01,
              ),
              child: Text(
                userProvider.currentUser!.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.04),
              child: Text(
                userProvider.currentUser!.email,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            CustomContainerButton(
              title: AppLocalizations.of(context)!.darkMode,
              suffix: CustomThemeSwitch(themeMode: themeProvider.appTheme),
              paddingHeight: 0,
              paddingWidth: width * 0.05,
            ),
            CustomDropdownMenu(),
            InkWell(
              onTap: onLogOut,
              overlayColor: WidgetStatePropertyAll(EventlyColors.transparent),
              child: CustomContainerButton(
                title: AppLocalizations.of(context)!.logout,
                suffix: FaIcon(
                  FontAwesomeIcons.arrowRightFromBracket,
                  color: EventlyColors.red,
                ),
                paddingHeight: height * 0.015,
                paddingWidth: width * 0.05,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onLogOut() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      EventlyRoutes.loginScreen,
      (route) => false,
    );
  }
}
