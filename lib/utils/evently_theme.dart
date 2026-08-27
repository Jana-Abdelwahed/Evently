import 'package:evently/utils/evently_colors.dart';
import 'package:evently/utils/evently_text_style.dart';
import 'package:flutter/material.dart';

class EventlyTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: EventlyColors.whiteBg,
    appBarTheme: AppBarThemeData(
      backgroundColor: EventlyColors.whiteBg,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: EventlyColors.mainBlue,
      selectionColor: EventlyColors.lightBlue.withAlpha(35),
      selectionHandleColor: EventlyColors.mainBlue
    ),
    textTheme: TextTheme(
      titleLarge: EventlyTextStyle.blackSemiBold20,
      titleMedium: EventlyTextStyle.greyW40016,
      titleSmall: EventlyTextStyle.mainBlueSemiBold14,
      bodyLarge: EventlyTextStyle.mainBlueSemiBold24,
      bodyMedium: EventlyTextStyle.whiteW50020,
      bodySmall: EventlyTextStyle.darkGreyW40014,
      labelMedium: EventlyTextStyle.mainBlueSemiBold18,
      labelSmall: EventlyTextStyle.whiteSemiBold14,
      displaySmall: EventlyTextStyle.mainBlueSemiBold14,
      headlineSmall: EventlyTextStyle.lightBlueSemiBold12,
      headlineMedium: EventlyTextStyle.blackW50016,
      headlineLarge: EventlyTextStyle.whiteW50016,
    ),
      primaryColor: EventlyColors.mainBlue,
      cardColor: EventlyColors.white,
      dividerColor: EventlyColors.whiteLightStroke,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: EventlyColors.darkBlue,
      appBarTheme: AppBarThemeData(
          backgroundColor: EventlyColors.darkBlue
      ),
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: EventlyColors.mainBlue,
          selectionColor: EventlyColors.lightBlue.withAlpha(35),
          selectionHandleColor: EventlyColors.mainBlue
      ),
      textTheme: TextTheme(
          titleLarge: EventlyTextStyle.whiteSemiBold20,
          titleMedium: EventlyTextStyle.whiteSecW40016,
          titleSmall: EventlyTextStyle.whiteSemiBold14,
          bodyLarge: EventlyTextStyle.whiteSemiBold24,
          bodyMedium: EventlyTextStyle.whiteW50020,
          bodySmall: EventlyTextStyle.secDarkW40014,
          labelMedium: EventlyTextStyle.whiteSemiBold18,
          labelSmall: EventlyTextStyle.lightBlueSemiBold14,
          displayMedium: EventlyTextStyle.lightBlueSemiBold18,
          headlineSmall: EventlyTextStyle.mainBlueSemiBold12,
          headlineMedium: EventlyTextStyle.whiteW50016,
          headlineLarge: EventlyTextStyle.whiteW50016
      ),
      primaryColor: EventlyColors.lightBlue,
      cardColor: EventlyColors.blueDarkInputs,
      dividerColor: EventlyColors.blueDarkStroke,
      highlightColor: EventlyColors.darkBlue
  );
}