import 'package:evently/Localization/app_localizations.dart';
import 'package:evently/Pages/tabs/home/widgets/event_item.dart';
import 'package:evently/Pages/tabs/home/widgets/tab_widget.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/dimensions.dart';
import 'package:evently/utils/evently_colors.dart';
import 'package:evently/utils/evently_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late EventProvider eventProvider;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventProvider.getAllEventsFromFireStore(userProvider.currentUser!.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    eventProvider = Provider.of<EventProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    eventProvider.getEventsCategory(context);

    List<FaIconData?> icons = [
      FontAwesomeIcons.compass,
      FontAwesomeIcons.bicycle,
      FontAwesomeIcons.cakeCandles,
      FontAwesomeIcons.book,
      FontAwesomeIcons.solidHandshake,
      FontAwesomeIcons.palette,
    ];

    var width = context.width;
    var height = context.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.01,
          ),
          child: Column(
            children: [
              Row(
                spacing: width * 0.04,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back ✨",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        userProvider.currentUser!.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    themeProvider.isDark
                        ? EventlyIcons.darkModeUnfill
                        : EventlyIcons.lightModeUnfill,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.008,
                      horizontal: width * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      languageProvider.appLanguage == "en"
                          ? AppLocalizations.of(context)!.en
                          : AppLocalizations.of(context)!.ar,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: DefaultTabController(
                  length: eventProvider.eventCategory.length,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: width * 0.015,
                          vertical: height * 0.02,
                        ),
                        indicatorColor: EventlyColors.transparent,
                        dividerColor: EventlyColors.transparent,
                        overlayColor: WidgetStatePropertyAll(
                          EventlyColors.transparent,
                        ),
                        tabAlignment: TabAlignment.start,
                        onTap: (index) {
                          eventProvider.changeSelectedIndex(
                            index,
                            userProvider.currentUser!.id,
                          );
                        },
                        tabs: eventProvider.eventCategory.asMap().entries.map((
                          entry,
                        ) {
                          int index = entry.key;
                          String eventName = entry.value;

                          return TabWidget(
                            eventName: eventName,
                            icon: icons[index],
                            iconSelectedColor: EventlyColors.white,
                            iconUnSelectedColor: Theme.of(context).primaryColor,
                            isSelected: eventProvider.selectedIndex == index,
                            selectedColor: Theme.of(context).primaryColor,
                            unselectedColor: Theme.of(context).cardColor,
                          );
                        }).toList(),
                      ),
                      Expanded(
                        child: eventProvider.filterList.isEmpty
                            ? Center(
                                child: Text(
                                  "No Events Found !",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  return EventItem(
                                    event: eventProvider.filterList[index],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: height * 0.01);
                                },
                                itemCount: eventProvider.filterList.length,
                              ),
                      ),
                    ],
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
