import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:evently/Localization/app_localizations.dart';
import 'package:evently/Pages/tabs/favorite/widgets/search_form_field.dart';
import 'package:evently/Pages/tabs/home/widgets/tab_widget.dart';
import 'package:evently/utils/evently_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../firebase_utils.dart';
import '../models/event_model.dart';
import '../providers/event_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../utils/dimensions.dart';
import '../utils/evently_colors.dart';
import '../utils/evently_images.dart';
import '../utils/snack_bar.dart';
import '../widgets/elevated_button.dart';

class EditEventDetailsScreen extends StatefulWidget {
  var formKey = GlobalKey<FormState>();
  final Event event;

  EditEventDetailsScreen({super.key, required this.event});

  @override
  State<EditEventDetailsScreen> createState() => _EditEventDetailsScreenState();
}

class _EditEventDetailsScreenState extends State<EditEventDetailsScreen> {
  late var titleController = TextEditingController(
    text: widget.event.eventTitle,
  );
  late var descriptionController = TextEditingController(
    text: widget.event.eventDescription,
  );
  var selectedEventCategory = "";
  String selectedEventImage = "";
  int selectedIndex = 0;
  DateTime? selectedDate;
  String formatDate = "";
  TimeOfDay? selectedTime;
  String formatTime = "";
  var title = "";
  var description = "";
  bool isDateEmpty = false;
  bool isTimeEmpty = false;
  late EventProvider eventProvider;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    eventProvider = Provider.of<EventProvider>(context);

    List<String> eventCategory = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.exhibition,
    ];
    List<FaIconData?> icons = [
      FontAwesomeIcons.bicycle,
      FontAwesomeIcons.cakeCandles,
      FontAwesomeIcons.book,
      FontAwesomeIcons.solidHandshake,
      FontAwesomeIcons.palette,
    ];
    List<String> eventImage = [
      EventlyImages.sportImage,
      EventlyImages.birthdayImage,
      EventlyImages.bookClubImage,
      EventlyImages.meetingImage,
      EventlyImages.exhibitionImage,
    ];
    List<String> eventImageDark = [
      EventlyImages.sportImageDark,
      EventlyImages.birthdayImageDark,
      EventlyImages.bookClubImageDark,
      EventlyImages.meetingImageDark,
      EventlyImages.exhibitionImageDark,
    ];
    selectedEventCategory = eventCategory[selectedIndex];
    selectedEventImage = themeProvider.isDark
        ? eventImageDark[selectedIndex]
        : eventImage[selectedIndex];
    var width = context.width;
    var height = context.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.addEvent,
          style: Theme.of(context).textTheme.headlineMedium,
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
                  ? Theme.of(context).cardColor
                  : EventlyColors.white,
              border: BoxBorder.all(
                color: themeProvider.isDark
                    ? Theme.of(context).dividerColor
                    : EventlyColors.whiteLightStroke,
              ),
            ),
            child: IconButton(
              highlightColor: EventlyColors.transparent,
              iconSize: 20,
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  EventlyRoutes.eventDetailsScreen,
                  arguments: widget.event,
                );
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              color: themeProvider.isDark
                  ? EventlyColors.white
                  : Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.01,
          ),
          child: Form(
            key: widget.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      image: AssetImage(
                        themeProvider.isDark
                            ? eventImageDark[selectedIndex]
                            : eventImage[selectedIndex],
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                DefaultTabController(
                  length: eventCategory.length,
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
                          selectedIndex = index;
                          setState(() {});
                        },
                        tabs: eventCategory.map((eventName) {
                          int index = eventCategory.indexOf(eventName);
                          return TabWidget(
                            eventName: eventName,
                            icon: icons[index],
                            iconSelectedColor: EventlyColors.white,
                            iconUnSelectedColor: Theme.of(context).primaryColor,
                            isSelected:
                                selectedIndex ==
                                eventCategory.indexOf(eventName),
                            selectedColor: Theme.of(context).primaryColor,
                            unselectedColor: Theme.of(context).cardColor,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01),
                  child: Text(
                    AppLocalizations.of(context)!.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SearchFormField(
                  hintText: "Event Title",
                  controller: titleController,
                  onChanged: (text) {
                    title = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter a Title";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01),
                  child: Text(
                    AppLocalizations.of(context)!.description,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SearchFormField(
                  hintText: "Event Description",
                  maxLines: 6,
                  controller: descriptionController,
                  onChanged: (text) {
                    description = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter a Description";
                    }
                    return null;
                  },
                ),
                Row(
                  spacing: width * 0.02,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.calendarDays,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      AppLocalizations.of(context)!.eventDate,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: WidgetStatePropertyAll(
                          EventlyColors.transparent,
                        ),
                        textStyle: WidgetStatePropertyAll(
                          Theme.of(context).textTheme.labelSmall!.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: isDateEmpty
                                ? EventlyColors.red
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                        foregroundColor: WidgetStatePropertyAll(
                          isDateEmpty
                              ? EventlyColors.red
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        selectDate();
                      },
                      child: Text(
                        selectedDate != null
                            ? formatDate
                            : DateFormat(
                                "d MMM yyyy",
                              ).format(widget.event.eventDate),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: width * 0.02,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.clock,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      AppLocalizations.of(context)!.eventTime,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: WidgetStatePropertyAll(
                          EventlyColors.transparent,
                        ),
                        textStyle: WidgetStatePropertyAll(
                          Theme.of(context).textTheme.labelSmall!.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: isTimeEmpty
                                ? EventlyColors.red
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                        foregroundColor: WidgetStatePropertyAll(
                          isTimeEmpty
                              ? EventlyColors.red
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        selectTime();
                      },
                      child: Text(
                        selectedTime != null
                            ? formatTime
                            : widget.event.eventTime,
                      ),
                    ),
                  ],
                ),
                CustomElevatedButton(
                  title: "Update Event",
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  onButtonClick: onButtonClick,
                  buttonColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectDate() async {
    var selectDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = selectDate;
    if (selectedDate != null) {
      formatDate = DateFormat("MMM d,yyyy").format(selectedDate!);
    }
    isDateEmpty = false;
    setState(() {});
  }

  Future<void> selectTime() async {
    var selectTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = selectTime;
    if (selectedTime != null) {
      formatTime = selectedTime!.format(context);
    }
    isTimeEmpty = false;
    setState(() {});
  }

  void onButtonClick() {
    setState(() {
      isDateEmpty = formatDate.isEmpty;
      isTimeEmpty = formatTime.isEmpty;
    });

    if (widget.formKey.currentState!.validate() == true &&
        formatTime.isNotEmpty &&
        formatDate.isNotEmpty) {
      Event event = Event(
        id: widget.event.id,
        eventCategory: selectedEventCategory,
        eventTitle: titleController.text,
        eventDescription: descriptionController.text,
        eventDate: selectedDate!,
        eventImage: selectedEventImage,
        eventTime: formatTime,
      );
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      FirebaseUtils.updateEvent(event, userProvider.currentUser!.id).then((
        value,
      ) {
        CustomSnackBar.show(
          context: context,
          title: "woohoo!",
          message: "Event Added Successfully",
          contentType: ContentType.success,
          color: Theme.of(context).primaryColor,
        );
        eventProvider.getAllEventsFromFireStore(userProvider.currentUser!.id);
        Navigator.pop(context);
      });
    }
  }
}
