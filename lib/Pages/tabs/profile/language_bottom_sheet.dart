import 'package:evently/Localization/app_localizations.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/utils/evently_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 24,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              languageProvider.changeLanguage("en");
            },
            child: languageProvider.appLanguage == "en"
                ? getSelectedLanguage(
                    language: AppLocalizations.of(context)!.english,
                  )
                : getUnselectedLanguage(
                    language: AppLocalizations.of(context)!.english,
                  ),
          ),
          InkWell(
            onTap: () {
              languageProvider.changeLanguage("ar");
            },
            child: languageProvider.appLanguage == "ar"
                ? getSelectedLanguage(
                    language: AppLocalizations.of(context)!.arabic,
                  )
                : getUnselectedLanguage(
                    language: AppLocalizations.of(context)!.arabic,
                  ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedLanguage({required language}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language, style: TextStyle(fontSize: 24)),
        Icon(Icons.check, color: EventlyColors.darkBlue),
      ],
    );
  }

  Widget getUnselectedLanguage({required language}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(language, style: TextStyle(fontSize: 24))],
    );
  }
}
