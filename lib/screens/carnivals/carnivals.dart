import 'package:fasching_app/data/carnival-list.dart';
import 'package:fasching_app/models/carnival.dart';
import 'package:fasching_app/screens/createCarnival/createCarnival.dart';
import 'package:fasching_app/widgets/carnival-card.dart';
import 'package:flutter/material.dart';

class CarnivalsPage extends StatefulWidget {
  static const routeName = '/';

  @override
  _CarnivalsPageState createState() => _CarnivalsPageState();
}

class _CarnivalsPageState extends State<CarnivalsPage> {
  final List<Carnival> carnivals = CarnivalList.getCarnivals();


  @override
  void initState() {
    super.initState();
    // Sort the carnivals by date
    carnivals.sort((a,b) => b.date.compareTo(a.date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        centerTitle: true,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: const Text('Faschingsliste'),
      ),
      body: _buildListView(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          onPressed: (){
            Navigator.of(context).pushNamed(CreateCarnivalPage.routeName);
          }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Widget _buildListView() {
    return Container(
        margin: EdgeInsets.only(top: 6),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: carnivals.length,
          itemBuilder: (BuildContext context, int index) {
            return CarnivalListItem(carnival: carnivals[index]);
          },
        )
    );
  }
}
