import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/dimensions.dart';
import 'package:evently/utils/evently_colors.dart';
import 'package:evently/utils/evently_routes.dart';
import 'package:evently/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatefulWidget {
  final bool isSelected;
  final Event event;

  const EventItem({super.key, this.isSelected = false, required this.event});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var eventProvider = Provider.of<EventProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var width = context.width;
    var height = context.height;
    return InkWell(
      overlayColor: WidgetStatePropertyAll(EventlyColors.transparent),
      onTap: () {
        Navigator.pushNamed(
          context,
          EventlyRoutes.eventDetailsScreen,
          arguments: widget.event,
        );
      },
      child: Container(
        height: height * 0.22,
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.027,
            vertical: height * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.02,
                ),
                decoration: BoxDecoration(
                  color: themeProvider.isDark
                      ? Theme.of(context).cardColor
                      : EventlyColors.whiteBg,
                  borderRadius: BorderRadius.circular(8),
                  border: BoxBorder.all(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  DateFormat("d MMM").format(widget.event.eventDate),
                  style: themeProvider.isDark
                      ? Theme.of(context).textTheme.labelSmall
                      : Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.02,
                ),
                decoration: BoxDecoration(
                  color: themeProvider.isDark
                      ? Theme.of(context).cardColor
                      : EventlyColors.whiteBg,
                  borderRadius: BorderRadius.circular(8),
                  border: BoxBorder.all(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.event.eventDescription,
                        style: Theme.of(context).textTheme.headlineMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      overlayColor: WidgetStatePropertyAll(
                        EventlyColors.transparent,
                      ),
                      onTap: () {
                        eventProvider.updateFavorite(
                          widget.event,
                          userProvider.currentUser!.id,
                        );
                        CustomSnackBar.show(
                          context: context,
                          title: "Woohoo!",
                          message: "Favorites Updated Successfully",
                          contentType: ContentType.success,
                          color: Theme.of(context).primaryColor,
                        );
                      },
                      child: FaIcon(
                        widget.event.isFavorite
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
