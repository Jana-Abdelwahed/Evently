import 'package:evently/Localization/app_localizations.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/evently_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/event_model.dart';
import '../providers/theme_provider.dart';
import '../utils/dimensions.dart';
import '../utils/evently_colors.dart';
import '../widgets/delete_button.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var eventProvider = Provider.of<EventProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var width = context.width;
    var height = context.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.eventDetails,
          style: theme.textTheme.headlineMedium,
        ),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.02,
            vertical: height * 0.01,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: themeProvider.isDark
                  ? theme.cardColor
                  : EventlyColors.white,
              border: BoxBorder.all(
                color: themeProvider.isDark
                    ? theme.dividerColor
                    : EventlyColors.whiteLightStroke,
              ),
            ),
            child: IconButton(
              highlightColor: EventlyColors.transparent,
              iconSize: 20,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              color: themeProvider.isDark
                  ? EventlyColors.white
                  : theme.primaryColor,
            ),
          ),
        ),
        actions: [
          Row(
            spacing: 8,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: themeProvider.isDark
                      ? theme.cardColor
                      : EventlyColors.white,
                  border: BoxBorder.all(
                    color: themeProvider.isDark
                        ? theme.dividerColor
                        : EventlyColors.whiteLightStroke,
                  ),
                ),
                child: IconButton(
                  highlightColor: EventlyColors.transparent,
                  iconSize: 20,
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      EventlyRoutes.editEventDetails,
                      arguments: widget.event,
                    );
                  },
                  icon: FaIcon(FontAwesomeIcons.penToSquare),
                  color: themeProvider.isDark
                      ? EventlyColors.white
                      : theme.primaryColor,
                ),
              ),
              CustomDeleteButton(event: widget.event),
            ],
          ),
        ],
        actionsPadding: EdgeInsetsGeometry.symmetric(
          vertical: height * 0.01,
          horizontal: width * 0.02,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: height * 0.2,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: BoxBorder.all(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
                image: DecorationImage(
                  image: AssetImage(widget.event.eventImage),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(widget.event.eventTitle, style: theme.textTheme.titleLarge),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                border: BoxBorder.all(color: theme.dividerColor, width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  spacing: 16,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: themeProvider.isDark
                            ? theme.cardColor
                            : EventlyColors.whiteBg,
                        border: BoxBorder.all(color: theme.dividerColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.calendarDays,
                        color: theme.primaryColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat("d MMMM").format(widget.event.eventDate),
                          style: theme.textTheme.headlineMedium,
                        ),
                        Text(
                          widget.event.eventTime,
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.description,
              style: theme.textTheme.titleLarge,
            ),
            Container(
              padding: EdgeInsets.all(16),
              height: height * 0.2,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                border: BoxBorder.all(color: theme.dividerColor, width: 1),
              ),
              child: Text(
                widget.event.eventDescription,
                style: theme.textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
