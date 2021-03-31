class Carnival{
  int id;
  String name;
  String location;
  DateTime date;
  bool isExpanded;
  List<int> favoriteByUsers;

  Carnival(
      {this.id, this.name, this.location, this.date, this.isExpanded = false, this.favoriteByUsers = const []});

  void addUserToFavorite(int guid) {
    if (!favoriteByUsers.contains(guid)) {
      favoriteByUsers.add(guid);
    }
  }

  void toggleFavorite(int guid) {
    isFavorite(guid) ? removeUserFromFavorite(guid) : addUserToFavorite(guid);
  }

  bool removeUserFromFavorite(int guid) {
    return favoriteByUsers.remove(guid);
  }

  bool isFavorite(int guid) {
    if (favoriteByUsers == null) {
      return false;
    }
    return favoriteByUsers.contains(guid);
  }
}