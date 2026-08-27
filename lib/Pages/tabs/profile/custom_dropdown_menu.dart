import 'package:evently/Localization/app_localizations.dart';
import 'package:evently/cache/cache_helper.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDropdownMenu extends StatefulWidget {
  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String selectedLanguage = "en";
  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: BoxBorder.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: DropdownButton<String>(
          hint: Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          style: Theme.of(context).textTheme.headlineMedium,
          dropdownColor: Theme.of(context).cardColor,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          underline: SizedBox(),
          value: languageProvider.appLanguage,
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Theme.of(context).primaryColor,
          ),
          isExpanded: true,
          borderRadius: BorderRadius.circular(16),
          menuWidth: MediaQuery.of(context).size.width * 0.65,
          items: [
            DropdownMenuItem(
              value: "en",
              child: Text(AppLocalizations.of(context)!.english),
            ),
            DropdownMenuItem(
              value: "ar",
              child: Text(AppLocalizations.of(context)!.arabic),
            ),
          ],
          onChanged: (String? newValue) async {
            selectedLanguage = newValue!;
            languageProvider.changeLanguage(newValue);
            await CacheHelper.setData(
              key: "language_selected",
              value: selectedLanguage,
            );
            CacheHelper.getData(key: "language_selected");
            setState(() {});
          },
        ),
      ),
    );
  }
}
