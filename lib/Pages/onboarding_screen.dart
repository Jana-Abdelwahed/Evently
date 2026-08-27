import 'package:evently/Localization/app_localizations.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/evently_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/page_view_item.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            onLastPage = (index == 2);
          });
        },
        children: [
          CustomPageViewItem(
            pageViewImage: themeProvider.isDark
                ? EventlyImages.secondPageViewNight
                : EventlyImages.secondPageView,
            title: AppLocalizations.of(context)!.onboarding2Title,
            description: AppLocalizations.of(context)!.onboarding2Description,
            controller: _controller,
            index: 0,
            isLastPage: onLastPage,
          ),
          CustomPageViewItem(
            pageViewImage: themeProvider.isDark
                ? EventlyImages.thirdPageViewNight
                : EventlyImages.thirdPageView,
            title: AppLocalizations.of(context)!.onboarding3Title,
            description: AppLocalizations.of(context)!.onboarding3Description,
            controller: _controller,
            index: 1,
            isLastPage: onLastPage,
          ),
          CustomPageViewItem(
            pageViewImage: themeProvider.isDark
                ? EventlyImages.fourthPageViewNight
                : EventlyImages.fourthPageView,
            title: AppLocalizations.of(context)!.onboarding4Title,
            description: AppLocalizations.of(context)!.onboarding4Description,
            controller: _controller,
            index: 2,
            isLastPage: onLastPage,
          ),
        ],
      ),
    );
  }
}
