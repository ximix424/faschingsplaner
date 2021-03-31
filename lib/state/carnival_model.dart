import 'dart:collection';

import 'package:fasching_app/models/carnival.dart';
import 'package:flutter/material.dart';


class CarnivalModel extends ChangeNotifier {
  final List<Carnival> _carnivalList = [
    Carnival(
        id: 1,
        name: "Gumpiger Donnerstag",
        location: "Weißenhorn",
        date: DateTime.now()),
    Carnival(id: 2, name: "", location: "Dietenheim", date: DateTime.now())
  ];

  UnmodifiableListView<Carnival> get carnivals => UnmodifiableListView(_carnivalList);

  void add(Carnival carnival) {
    _carnivalList.add(carnival);
    notifyListeners();
  }


  void remove(int id) {
    _carnivalList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}