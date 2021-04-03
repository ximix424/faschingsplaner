import 'package:date_format/date_format.dart';
import 'package:faschingsplaner/models/carnival_model.dart';
import 'package:faschingsplaner/views/home_view/home_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AddView extends StatefulWidget {

  static const routeName = '/add';

  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  final _eventFormKey = GlobalKey<FormState>();
  final _formResult = Carnival();

  TextEditingController _date = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CloseButton(color: Colors.white,),
          title: Text("Fasching hinzufügen"),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(58, 66, 86, 1.0),
              ),
              child: Text("SAVE"),
              onPressed: _submitForm,
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: _eventFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                // "Faschingsname" form
                TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      icon: Icon(Icons.sports_bar_outlined),
                      labelText: 'Faschingsname',
                      hintText: 'Faschingsame eingeben'),
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  initialValue: _formResult.name,
                  validator: (eventName) {
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  onSaved: (carnivalName) => _formResult.name = carnivalName,
                ),

                SizedBox(height: 16),

                // "Standort" form
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Standort *',
                    hintText: 'Standort eingeben',
                    icon: Icon(Icons.location_on_outlined),
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  initialValue: _formResult.location,
                  validator: (carnivalLocation) {
                    if (carnivalLocation.isEmpty) {
                      return 'Ungültiger Standort';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  onSaved: (carnivalLocation) =>
                      _formResult.location = carnivalLocation,
                ),

                SizedBox(height: 16),

                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _date,
                      decoration: const InputDecoration(
                        labelText: 'Datum',
                        icon: Icon(Icons.date_range_outlined),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _submitForm() {
    final FormState form = _eventFormKey.currentState;
    if (form.validate()) {
      form.save();
      print('Neuer Fasching mit folgenden Informationen gespeichert:\n');
      print(_formResult.toJson());

      // Add carnival to database
      _database.reference().child("carnival").push().set(_formResult.toJson());
      Navigator.of(context).pushNamed(HomeView.routeName);
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime selectedDate = await showDatePicker(
        context: context,
        locale: const Locale("de", "DE"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
        helpText: 'Wähle ein Datum');
    if (selectedDate != null && selectedDate != _formResult.date)
      setState(() {
        _formResult.date = selectedDate;
        _date.value = TextEditingValue(
            text: formatDate(selectedDate, [dd, '.', mm, '.', yyyy]));
      });
  }
}
