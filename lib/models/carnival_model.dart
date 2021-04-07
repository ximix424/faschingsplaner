import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Carnival {
  String carnivalId;
  String name;
  String location;
  DateTime date;
  List<String> favoriteByUsers = [];

  Carnival(
      {@required this.carnivalId,
      this.name,
      @required this.location,
      @required this.date,
      this.favoriteByUsers});

  Map<String, dynamic> toMap() => {
        "name": this.name,
        "location": this.location,
        "date": this.date,
        "favoriteByUsers": this.favoriteByUsers,
      };

  Carnival.fromMap(QueryDocumentSnapshot queryDocumentSnapshot) {
    Map<dynamic, dynamic> map = queryDocumentSnapshot.data();

    carnivalId = queryDocumentSnapshot.id;
    print("CarnivalId: " + carnivalId);

    name = map['name'];
    location = map['location'];
    date = DateTime.parse(map['date'].toDate().toString());

    if (map["favoriteByUsers"] != null) {
      favoriteByUsers = List.from(map["favoriteByUsers"]);
    } else {
      favoriteByUsers = [];
    }
  }

  void toggleFavorite(String userId) {
    isFavorite(userId)
        ? removeUserFromFavorite(userId)
        : addUserToFavorite(userId);
  }

  void addUserToFavorite(String userId) {
    if (!favoriteByUsers.contains(userId)) {
      favoriteByUsers.add(userId);
    }
  }

  bool removeUserFromFavorite(String userId) {
    return favoriteByUsers.remove(userId);
  }

  bool isFavorite(String userId) {
    if (favoriteByUsers == null) {
      return false;
    }
    return favoriteByUsers.contains(userId);
  }
}