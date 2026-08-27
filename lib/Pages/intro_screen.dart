import 'package:evently/Localization/app_localizations.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/evently_icons.dart';
import 'package:evently/utils/evently_images.dart';
import 'package:evently/widgets/language_container.dart';
import 'package:evently/widgets/theme_mode_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/dimensions.dart';
import '../utils/evently_routes.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = context.width;
    var height = context.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        child: SafeArea(
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(EventlyImages.evently),
              Expanded(
                child: Image.asset(
                  themeProvider.isDark
                      ? EventlyImages.firstPageViewNight
                      : EventlyImages.firstPageView,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.onboarding1Title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.start,
              ),
              Text(
                AppLocalizations.of(context)!.onboarding1Description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Spacer(),
                  CustomLanguageContainer(
                    langCode: "en",
                    language: AppLocalizations.of(context)!.english,
                  ),
                  CustomLanguageContainer(
                    langCode: "ar",
                    language: AppLocalizations.of(context)!.arabic,
                  ),
                ],
              ),
              Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Spacer(),
                  CustomThemeModeContainer(
                    themeMode: ThemeMode.light,
                    icon: EventlyIcons.lightMode,
                  ),
                  CustomThemeModeContainer(
                    themeMode: ThemeMode.dark,
                    icon: EventlyIcons.darkMode,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.01),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).primaryColor,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      EventlyRoutes.onboardingScreen,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.015),
                    child: Text(
                      AppLocalizations.of(context)!.letsStart,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
