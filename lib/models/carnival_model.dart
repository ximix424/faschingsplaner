import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Carnival{
  String carnivalId;
  String name;
  String location;
  DateTime date;
  List<String> favoriteByUsers;

  Carnival(
      {this.carnivalId, this.name, this.location, this.date, this.favoriteByUsers = const []});

  // Extract object
  Carnival.fromSnapshot(DataSnapshot snapshot) :
        carnivalId = snapshot.key,
        name = snapshot.value["name"],
        location = snapshot.value["location"],
        date = DateTime.parse(snapshot.value["date"]),
        // favoriteByUsers = snapshot.value["favoriteByUsers"];
        favoriteByUsers = (snapshot.value["favoriteByUsers"] as List)
            ?.map((item) => item as String)
            ?.toList();

  // Wrap object
  toJson() {
    return {
      "name": name,
      "location": location,
      "date": date.toString(),
      "favoriteByUsers": (favoriteByUsers==null) ? [] : List.from(favoriteByUsers),
    };

  }

  void addUserToFavorite(String userId) {
    if (!favoriteByUsers.contains(userId)) {
      favoriteByUsers.add(userId);
    }
  }

  void toggleFavorite(String userId) {
    isFavorite(userId) ? removeUserFromFavorite(userId) : addUserToFavorite(userId);
    print('favorite users: ${favoriteByUsers.toString()}');
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