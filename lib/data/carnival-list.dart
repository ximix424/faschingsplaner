import 'package:fasching_app/models/carnival.dart';

class CarnivalList {
  static List<Carnival> getCarnivals() {
    return [
      Carnival(
        id: 1,
        name: "Gumpiger",
        location: "Weißenhorn",
        date: DateTime.now(),
        favoriteByUsers: [],
      ),
      Carnival(
        id: 2,
        name: "",
        location: "Dillingen a.d. Donau",
        date: DateTime.now().add(Duration(days: 3)),
        favoriteByUsers: [],
      ),
      Carnival(
        id: 3,
        name: "",
        location: "Illertissen",
        date: DateTime.now().add(Duration(days: 1)),
        favoriteByUsers: [],
      ),
      Carnival(
        id: 4,
        name: "",
        location: "Dietenheim",
        date: DateTime.now().add(Duration(days: 12)),
        favoriteByUsers: [],
      ),
    ];
  }
}