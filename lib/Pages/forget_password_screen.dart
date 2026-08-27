import 'package:evently/Localization/app_localizations.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/evently_images.dart';
import 'package:evently/utils/evently_routes.dart';
import 'package:evently/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/dimensions.dart';
import '../utils/evently_colors.dart';

class ForgetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = context.width;
    var height = context.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.01,
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: 35,
              children: [
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: height * 0.05,
                        maxWidth: width * 0.4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: themeProvider.isDark
                            ? Theme.of(context).cardColor
                            : EventlyColors.white,
                        border: BoxBorder.all(
                          color: themeProvider.isDark
                              ? Theme.of(context).dividerColor
                              : EventlyColors.whiteLightStroke,
                        ),
                      ),
                      child: IconButton(
                        highlightColor: EventlyColors.transparent,
                        iconSize: 20,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            EventlyRoutes.loginScreen,
                          );
                        },
                        icon: Icon(Icons.arrow_back_ios_new_rounded),
                        color: themeProvider.isDark
                            ? EventlyColors.white
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.forgetPasswordTitle,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  themeProvider.isDark
                      ? EventlyImages.forgetPasswordNight
                      : EventlyImages.forgetPasswordLight,
                ),
                CustomElevatedButton(
                  title: AppLocalizations.of(context)!.resetPassword,
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  onButtonClick: onForgetPasswordClick,
                  buttonColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onForgetPasswordClick() {}
}
