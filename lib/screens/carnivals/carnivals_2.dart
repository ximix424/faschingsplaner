import 'package:fasching_app/data/carnival-list.dart';
import 'package:fasching_app/models/carnival.dart';
import 'package:fasching_app/widgets/carnival-card.dart';
import 'package:flutter/material.dart';


class CarnivalsPage2 extends StatefulWidget {
  static const routeName = '/test';

  @override
  _CarnivalsPage2State createState() => _CarnivalsPage2State();

}

class _CarnivalsPage2State extends State<CarnivalsPage2> {
  final List<Carnival> _carnivals = CarnivalList.getCarnivals();

  Widget _buildExpansionPanelList() {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _carnivals[index].isExpanded = !isExpanded;
          });
        },
        children: _carnivals.map<ExpansionPanel>((Carnival carnival) {
          return ExpansionPanel(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text(carnival.location),
                trailing: Icon(Icons.favorite_border_outlined),);},
            body: ListTile(title: Text(carnival.name),),
            isExpanded: carnival.isExpanded,
          );
        }).toList(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faschingsliste'),
      ),
      body: _buildExpansionPanelList(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          onPressed: (){Navigator.of(context).pushNamed('/createCarnival');}
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
