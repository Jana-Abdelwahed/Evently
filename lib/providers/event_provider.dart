import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Localization/app_localizations.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../models/event_model.dart';

class EventProvider extends ChangeNotifier {
  List<Event> eventsList = [];
  List<String> eventCategory = [];
  List<Event> filterList = [];
  List<Event> favoriteList = [];
  int selectedIndex = 0;

  void getEventsCategory(BuildContext context) {
    eventCategory = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.exhibition,
    ];
  }

  Future<void> getAllEventsFromFireStore(String uId) async {
    QuerySnapshot<Event> querySnapShot =
        await FirebaseUtils.getEventsCollection(uId).orderBy("eventDate").get();
    eventsList = querySnapShot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterList = eventsList;
    notifyListeners();
  }

  Future<void> getFilterEventsFromFireStore(String uId) async {
    if (eventCategory.isEmpty || selectedIndex >= eventCategory.length) {
      return;
    }

    var querySnapShot = await FirebaseUtils.getEventsCollection(
      uId,
    ).where("category", isEqualTo: eventCategory[selectedIndex]).get();

    filterList = querySnapShot.docs.map((doc) {
      return doc.data();
    }).toList();

    notifyListeners();
  }

  Future<void> updateFavorite(Event event, String uId) async {
    try {
      await FirebaseUtils.getEventsCollection(
        uId,
      ).doc(event.id).update({"isFavorite": !event.isFavorite});

      print("Is Favorite Updated Successfully :)");

      // Refresh lists after Firestore write completes
      if (selectedIndex == 0) {
        await getAllEventsFromFireStore(uId);
      } else {
        await getFilterEventsFromFireStore(uId);
      }
      await getFavoriteEvents(uId);
    } catch (e) {
      print("Error updating favorite: $e");
    }
  }

  Future<void> getFavoriteEvents(String uId) async {
    try {
      var querySnapShot = await FirebaseUtils.getEventsCollection(
        uId,
      ).where("isFavorite", isEqualTo: true).get();

      favoriteList = querySnapShot.docs.map((doc) => doc.data()).toList();

      // Sort by eventDate locally in memory
      favoriteList.sort((a, b) => a.eventDate.compareTo(b.eventDate));

      notifyListeners();
    } catch (e) {
      print("Error fetching favorite events: $e");
    }
  }

  Future<void> editEvent(Event event, String uId, String newValue) async {
    try {
      await FirebaseUtils.updateEvent(event, uId);
      print("Event Updated Successfully :)");
      if (selectedIndex == 0) {
        await getAllEventsFromFireStore(uId);
      } else {
        await getFilterEventsFromFireStore(uId);
      }
    } catch (e) {
      print("Error editing event: $e");
    }
  }

  Future<void> deleteEvent(Event event, String uId) async {
    try {
      await FirebaseUtils.deleteEvent(event, uId);
      print("Event Deleted Successfully :)");
      if (selectedIndex == 0) {
        await getAllEventsFromFireStore(uId);
      } else {
        await getFilterEventsFromFireStore(uId);
      }
      await getFavoriteEvents(uId);
    } catch (e) {
      print("Error deleting event: $e");
    }
  }

  void changeSelectedIndex(int newIndex, String uId) {
    selectedIndex = newIndex;
    selectedIndex == 0
        ? getAllEventsFromFireStore(uId)
        : getFilterEventsFromFireStore(uId);
  }
}
