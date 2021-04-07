import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faschingsplaner/models/carnival_model.dart';
import 'package:faschingsplaner/screens/add/add.dart';
import 'package:faschingsplaner/screens/widgets/loading_screen.dart';
import 'package:faschingsplaner/services/authentication.dart';
import 'package:faschingsplaner/services/firestore_service.dart';
import 'package:flutter/material.dart';

import 'widgets/carnival_list_item.dart';
import 'widgets/logout_button.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  // Firebase Authentication
  HomeScreen({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final AuthService auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  signOut() async {
    try {
      await widget.auth.signOut();
      Navigator.pop(context);
      widget.logoutCallback();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text("Logout successful", style: TextStyle(color: Colors.green)),
      ));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Logout failed", style: TextStyle(color: Colors.red)),
      ));
    }
  }

  Widget _buildCarnivalListView() {
    return Container(
      margin: EdgeInsets.only(top: 6),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirestoreService().getAllCarnivalsAsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return new LoadingScreen();
          else if (snapshot.hasData) {
            return new ListView.builder(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return new CarnivalListItem(
                    carnival: Carnival.fromMap(snapshot.data.docs[index]),
                    userId: widget.userId,
                  );
                });
          } else {
            return Center(
              child: Text(snapshot.error),
            );
          }
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Faschingsliste'),
      actions: [LogoutButton(logoutCallback: signOut)],
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AddScreen.routeName);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: _buildAppBar(),
      body: _buildCarnivalListView(),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
