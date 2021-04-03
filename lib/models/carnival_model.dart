import 'package:firebase_database/firebase_database.dart';

class Carnival{
  String carnivalId;
  String name;
  String location;
  DateTime date;
  List<String> favoriteByUsers = [];

  Carnival(
      {this.carnivalId, this.name, this.location, this.date, this.favoriteByUsers});

  // Extract the carnival object from firebase database
  Carnival.fromSnapshot(DataSnapshot snapshot) {
    carnivalId = snapshot.key;
    name = snapshot.value["name"];
    location = snapshot.value["location"];
    date = DateTime.parse(snapshot.value["date"]);

    if (snapshot.value["favoriteByUsers"] != null) {
      favoriteByUsers = List.from(snapshot.value["favoriteByUsers"]);
    }
  }

  // Wrap the carnival object to a JSON
  toJson() {
    return {
      "name": name,
      "location": location,
      "date": date.toString(),
      "favoriteByUsers": (favoriteByUsers == null) ? [] : List.from(
          favoriteByUsers),
    };
  }

  void addUserToFavorite(String userId) {
    if (!favoriteByUsers.contains(userId)) {
      favoriteByUsers.add(userId);
    }
  }

  void toggleFavorite(String userId) {
    isFavorite(userId) ? removeUserFromFavorite(userId) : addUserToFavorite(userId);
    // print('favorite users: ${favoriteByUsers.toString()}');
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