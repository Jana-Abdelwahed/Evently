import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  String get language;

  String get english;

  String get arabic;

  String get theme;

  String get darkMode;

  String get lightMode;

  String get onboarding1Title;

  String get onboarding1Description;

  String get letsStart;

  String get onboarding2Title;

  String get onboarding2Description;

  String get next;

  String get skip;

  String get onboarding3Title;

  String get onboarding3Description;

  String get onboarding4Title;

  String get onboarding4Description;

  String get getStarted;

  String get loginTitle;

  String get enterEmail;

  String get enterPassword;

  String get forgetPassword;

  String get login;

  String get logout;

  String get dontHaveAccount;

  String get signup;

  String get or;

  String get loginWithGoogle;

  String get registerTitle;

  String get enterName;

  String get confirmPassword;

  String get signUp;

  String get alreadyHaveAccount;

  String get createYourAccount;

  String get signUpWithGoogle;

  String get forgetPasswordTitle;

  String get resetPassword;

  String get home;

  String get favorite;

  String get profile;

  String get en;

  String get ar;

  String get all;

  String get sport;

  String get birthday;

  String get bookClub;

  String get meeting;

  String get exhibition;

  String get searchForEvent;

  String get addEvent;

  String get eventDetails;

  String get chooseTime;

  String get chooseDate;

  String get eventDate;

  String get eventTime;

  String get title;

  String get description;

  String get noEventsFound;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-Localization configuration '
    'that was used.',
  );
}
