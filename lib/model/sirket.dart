import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Sirket {
  static List<String> getChatingTiles(String currentUserId) {
    CollectionReference users = FirebaseFirestore.instance.collection("sirket");
    List<String> sessionIdList = <String>[];
    //trying to get the array field of the document that has an id of currentUserId
    users.doc(currentUserId).get().then((snapshot) => {
          //trying to loop through the array called sessions and adding every string element into the list
          for (String elem in snapshot['araclar']) {sessionIdList.add(elem)}
        });
    print("list is here :");
    print(sessionIdList);
    return sessionIdList;
  }
}
