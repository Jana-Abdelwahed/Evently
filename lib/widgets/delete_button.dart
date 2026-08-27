import 'package:evently/models/event_model.dart';
import 'package:evently/utils/evently_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../utils/evently_colors.dart';

class CustomDeleteButton extends StatelessWidget{
  final Event event;

  const CustomDeleteButton({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
  var themeProvider = Provider.of<ThemeProvider>(context);
  var eventProvider = Provider.of<EventProvider>(context);
  var userProvider = Provider.of<UserProvider>(context);

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:
            themeProvider.isDark
                ? Theme.of(context).cardColor
                : EventlyColors.white,
            border: BoxBorder.all(
                color:
                themeProvider.isDark
                    ? Theme.of(context).dividerColor
                    : EventlyColors.whiteLightStroke
            )
        ),
        child: IconButton(
            highlightColor: EventlyColors.transparent,
            iconSize: 20,
            onPressed: () {
              eventProvider.deleteEvent(event,userProvider.currentUser!.id);
              Navigator.pushReplacementNamed(context, EventlyRoutes.homeScreen,arguments: event);
            },
            icon: FaIcon(FontAwesomeIcons.trashCan),
            color: EventlyColors.red
        )
    );
  }

}