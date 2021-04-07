import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faschingsplaner/models/carnival_model.dart';

class FirestoreService {
  final CollectionReference _carnivalCollectionReference =
      FirebaseFirestore.instance.collection('Carnivals');

  Stream<QuerySnapshot> getAllCarnivalsAsStream() {
    return _carnivalCollectionReference.snapshots();
  }

  Future<List<Carnival>> getAllCarnivalsAsList() async {
    QuerySnapshot querySnapshot = await _carnivalCollectionReference.get();
    return querySnapshot.docs
        .map((docSnapshot) => Carnival.fromMap(docSnapshot))
        .toList();
  }

  void sortByDate(List<Carnival> carnivalsList) {
    if (carnivalsList.length > 1) {
      carnivalsList.sort((a, b) => b.date.compareTo(a.date));
    }
  }

  Future addCarnival(Carnival carnival) async {
    try {
      await _carnivalCollectionReference.add(carnival.toMap());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future getCarnival(String carnivalId) async {
    try {
      var carnivalData =
          await _carnivalCollectionReference.doc(carnivalId).get();
      return Carnival.fromMap(carnivalData);
    } catch (e) {
      return e.toString();
    }
  }

  updateCarnivalFavorites(Carnival carnival) async {
    await _carnivalCollectionReference
        .doc(carnival.carnivalId)
        .update({
          "favoriteByUsers": FieldValue.arrayUnion(carnival.favoriteByUsers)
        })
        .then((value) => print("Carnival Updated"))
        .catchError((error) => print("Failed to update carnival: $error"));
  }
}
