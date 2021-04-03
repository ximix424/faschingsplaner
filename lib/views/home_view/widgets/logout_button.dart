import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  LogoutButton({this.logoutCallback});

  final VoidCallback logoutCallback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Color.fromRGBO(58, 66, 86, 1.0),
        ),
        child: Icon(Icons.logout, color: Colors.white),
        onPressed: logoutCallback,
      ),
    );
  }
}
