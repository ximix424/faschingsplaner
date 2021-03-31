import 'package:badges/badges.dart';
import 'package:fasching_app/models/carnival.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CarnivalListItem extends StatefulWidget {
  final Carnival carnival;

  CarnivalListItem({this.carnival});

  @override
  _CarnivalListItemState createState() => _CarnivalListItemState();
}

class _CarnivalListItemState extends State<CarnivalListItem> {
  bool isFavorite = false;

  // TODO: Get current user and corresponding guid
  int userGuid = 5693;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: _makeExpansionTile(),
      ),
    );
  }

  bool _isDatePassed() {
    return DateTime.now().isAfter(widget.carnival.date);
  }

  Widget _makeExpansionTile() {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        height: double.infinity,
        padding: EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
            border:
                Border(right: BorderSide(width: 1.0, color: Colors.white24))),
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
            // Icon(Icons.sports_bar,
            //     color: _isDatePassed()
            //         ? Colors.red.shade600
            //         : Colors.green.shade600),
          ],
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Text(DateFormat('dd. MMM').format(widget.carnival.date)),
        //   ],
        // ),
      ),
      title: Text(widget.carnival.location,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Text(DateFormat('hh:mm').format(widget.carnival.date)),
      trailing: _makeFavoriteIcon(),
      children: [Text("Test")],
    );
  }

  Widget _makeFavoriteIcon() {
    return GestureDetector(
        onTap: () {
          setState(() {
            widget.carnival.toggleFavorite(userGuid);
            final snackBar = SnackBar(content: Text("Toggled favorit"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        },
        child: Badge(
          badgeContent: Text(
            '${widget.carnival.favoriteByUsers.length}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          badgeColor: Colors.red,
          elevation: 8,
          position: BadgePosition.topEnd(top: -10, end: -10),
          child: widget.carnival.isFavorite(userGuid)
              ? Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 30,
                )
              : Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.white,
                  size: 30,
                ),
        ));
  }
}
