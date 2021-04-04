import 'package:badges/badges.dart';
import 'package:faschingsplaner/models/carnival_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'user_list_item.dart';

class CarnivalListItem extends StatefulWidget {
  CarnivalListItem({this.carnival, this.userId});

  final Carnival carnival;
  final String userId;

  @override
  _CarnivalListItemState createState() => _CarnivalListItemState();
}

class _CarnivalListItemState extends State<CarnivalListItem> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    print("Favorite: " + widget.carnival.favoriteByUsers.toString());
    // widget.carnival.favoriteByUsers = [];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: _buildExpansionTile(),
      ),
    );
  }

  bool _isDatePassed() {
    return DateTime.now().isAfter(widget.carnival.date);
  }

  Widget _buildExpansionTile() {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: _buildLeadingContainer(),
      title: Text(widget.carnival.location,
          style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(DateFormat('hh:mm').format(widget.carnival.date)),
      trailing: _buildTrailingContainer(),
      children: [_buildExpansionContainer()],
    );
  }

  Widget _buildLeadingContainer() {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1.0, color: Colors.white24))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
            width: 17,
            decoration: BoxDecoration(
                color: _isDatePassed()
                    ? Colors.redAccent.shade100
                    : Colors.greenAccent.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  // bottomRight: Radius.circular(10)
                )),
            child: Text(
              DateFormat('dd').format(widget.carnival.date)[0],
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Arial', fontSize: 24),
            ),
          ),
          SizedBox(width: 1),
          Container(
            height: 30,
            width: 17,
            decoration: BoxDecoration(
                color: _isDatePassed()
                    ? Colors.redAccent.shade100
                    : Colors.greenAccent.shade200,
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Text(
              DateFormat('dd').format(widget.carnival.date)[1],
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Arial', fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionContainer() {
    return widget.carnival.favoriteByUsers.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: widget.carnival.favoriteByUsers.length,
            itemBuilder: (BuildContext context, int index) {
              return UserListItem(
                  userId: widget.carnival.favoriteByUsers[index]);
            },
          )
        : Text("");
  }

  Widget _buildTrailingContainer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.carnival.toggleFavorite(widget.userId);

          FirebaseDatabase _database = FirebaseDatabase.instance;

          _database
              .reference()
              .child("carnival")
              .child(widget.carnival.carnivalId)
              .set(widget.carnival.toJson());
        });
      },
      child: _buildBadge(),
    );
  }

  Widget _buildBadge() {
    return widget.carnival.favoriteByUsers.length > 0
        ? Badge(
            badgeContent: Text(
              '${widget.carnival.favoriteByUsers.length}',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            badgeColor: Colors.blue,
            elevation: 8,
            position: BadgePosition.topEnd(top: -10, end: -10),
            child: widget.carnival.isFavorite(widget.userId)
                ? Icon(
                    Icons.favorite,
                    color: Colors.blue,
                    size: 30,
                  )
                : _buildIcon(),
          )
        : _buildIcon();
  }

  Widget _buildIcon() {
    return Icon(
      Icons.favorite_border_outlined,
      color: Colors.white,
      size: 30,
    );
  }
}
