class Event {
  static const String collectionName = "Events";

  String id;
  String eventTitle;
  String eventDescription;
  String eventCategory;
  DateTime eventDate;
  String eventTime;
  String eventImage;
  bool isFavorite;

  Event({
    this.id = "",
    required this.eventCategory,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.eventTime,
    required this.eventImage,
    this.isFavorite = false,
  });

  Event.fromJson(Map<String, dynamic> data)
    : this(
        id: data["id"],
        eventCategory: data["category"],
        eventTitle: data["title"],
        eventDescription: data["description"],
        eventDate: DateTime.fromMillisecondsSinceEpoch(data["eventDate"]),
        eventTime: data["eventTime"],
        eventImage: data["eventImage"],
        isFavorite: data["isFavorite"] as bool,
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "category": eventCategory,
      "title": eventTitle,
      "description": eventDescription,
      "eventDate": eventDate.millisecondsSinceEpoch,
      "eventTime": eventTime,
      "eventImage": eventImage,
      "isFavorite": isFavorite,
    };
  }
}
