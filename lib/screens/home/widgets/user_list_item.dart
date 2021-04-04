import 'package:flutter/material.dart';

class UserListItem extends StatefulWidget {
  UserListItem({this.userId});

  final String userId;

  @override
  _UserListItemState createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: ListTile(
        minLeadingWidth: 0,
        tileColor: Color.fromRGBO(58, 66, 86, 1.0),
        leading: Icon(Icons.account_circle, color: Colors.white),
        title: Text(widget.userId),
      ),
    );
  }
}
