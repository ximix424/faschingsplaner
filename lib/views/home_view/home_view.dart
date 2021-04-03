import 'dart:async';

import 'package:faschingsplaner/models/carnival_model.dart';
import 'package:faschingsplaner/views/add_carnival_view/add_carnival_view.dart';
import 'package:faschingsplaner/views/auth/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../widgets/carnival_list_item_view.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/home';

  // Firebase Authentication
  HomeView({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final List<Carnival> _carnivals = CarnivalList.getCarnivals();

  // Firebase Database
  List<Carnival> _carnivalList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _carnivalQuery;


  @override
  void initState() {
    super.initState();

    _carnivalList = [];
    _carnivalQuery = _database
      .reference()
      .child("carnival")
      .orderByChild("carnivalId");

    _onTodoAddedSubscription = _carnivalQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription =
        _carnivalQuery.onChildChanged.listen(onEntryChanged);
    // Sort the carnivals by date
    _carnivalList.sort((a,b) => b.date.compareTo(a.date));
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _carnivalList.singleWhere((carnival) {
      return carnival.carnivalId == event.snapshot.key;
    });

    setState(() {
      _carnivalList[_carnivalList.indexOf(oldEntry)] =
          Carnival.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _carnivalList.add(Carnival.fromSnapshot(event.snapshot));
    });
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        centerTitle: true,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text('Faschingsliste'),
      ),
      body: _buildListView(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          onPressed: (){
            Navigator.of(context).pushNamed(AddView.routeName);
          }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Widget _buildListView() {
    return Container(
      margin: EdgeInsets.only(top: 6),
      child: _carnivalList.length > 0
          ? new ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemCount: _carnivalList.length,
              itemBuilder: (BuildContext context, int index) {
                return CarnivalListItem(
                    carnival: _carnivalList[index], userId: widget.userId);
              })
          : Container(),
    );
  }
}
