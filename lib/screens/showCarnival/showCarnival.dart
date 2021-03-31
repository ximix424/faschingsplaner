import 'package:fasching_app/models/carnival.dart';
import 'package:flutter/material.dart';

class ShowCarnivalPage extends StatelessWidget {
  static const routeName = '/showCarnival';


  @override
  Widget build(BuildContext context) {
    final Carnival carnival = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(carnival.location),
      ),
      body: Center(
        child: Text(carnival.location),
      ),
    );
  }
}
