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
        onPressed: () {
          showDialog<void>(
              context: context,
              builder: (context) => _buildAlertDialog(context));
        },
      ),
    );
  }

  Widget _buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Logout?',
        // textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
      ),
      content: Text('This will take you back to the login screen.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'CANCEL',
            style: TextStyle(fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: logoutCallback,
          child: Text(
            'LOGOUT',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
