import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/models/my_user.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseUtils {

  static CollectionReference<Event> getEventsCollection(String uId){
   return getUsersCollection().doc(uId)
         .collection(Event.collectionName)
        .withConverter<Event>(
      fromFirestore: (snapshot, options) => Event.fromJson(snapshot.data()!),
      toFirestore: (event, options) => event.toJson(),
    );
  }

  static Future<void> addEventToFireStore(Event event,String uId){
    var collectionRef = getEventsCollection(uId); //collection Ref
    var docRef = collectionRef.doc();   //document Ref
    event.id = docRef.id; //auto id
      return docRef.set(event);
  }


  static CollectionReference<MyUser> getUsersCollection(){
   return FirebaseFirestore.instance.collection(MyUser.collectionName)
    .withConverter(
        fromFirestore: (snapshot, options) => MyUser.fromJson(snapshot.data()!),
        toFirestore: (myUser, options) => myUser.toJson(),
    );
  }

  static Future<void> addUserToFireStore(MyUser myUser){
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUsersFromFireStore(String id) async {
    var querySnapShot = await getUsersCollection().doc(id).get();
    return querySnapShot.data();
  }

  static Future<void> deleteEvent(Event event,String uId)async{
   return await getEventsCollection(uId)
        .doc(event.id)
        .delete();
  }


  static Future<void> updateEvent(Event event,String uId)async{
    return await getEventsCollection(uId)
        .doc(event.id)
        .update({
      "title":       event.eventTitle,
      "category":    event.eventCategory,
      "description": event.eventDescription,
      "eventDate":   event.eventDate.millisecondsSinceEpoch,
      "eventTime":   event.eventTime,
      "eventImage":  event.eventImage,
        });
  }
}