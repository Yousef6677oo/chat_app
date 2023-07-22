import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/my_user.dart';
import '../model/room.dart';

class MyDataBase {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (doc, _) => MyUser.fromFireStore(doc.data()!),
            toFirestore: (user, option) => user.toFireStore());
  }

  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
        fromFirestore: (doc, _) => Room.fromFireStore(doc.data()!),
        toFirestore: (room, option) => room.toFireStore());
  }

  static Future<MyUser?> insertUser(MyUser user) async {
    var collection = getUserCollection();
    var docRef = collection.doc(user.id);
    var result = await docRef.set(user);
    return user;
  }

  static Future<MyUser?> getUserById(String uid) async {
    var collection = getUserCollection();
    var docRef = collection.doc(uid);
    var result = await docRef.get();
    return result.data();
  }

  static Future<void>createRoom(Room room){
    var docRef  = getRoomsCollection().doc();
    room.id=docRef.id;
    return docRef.set(room);
  }
}
