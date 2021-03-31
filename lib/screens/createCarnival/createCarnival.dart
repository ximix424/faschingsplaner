import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateCarnival {
  String eventName;
  String eventLocation;
  DateTime eventDate;

  CreateCarnival({this.eventName, this.eventLocation, this.eventDate});

  Map<String, dynamic> toJson() => {
        'eventName': eventName,
        'eventLocation': eventLocation,
        'eventDate': eventDate,
      };
}

class CreateCarnivalPage extends StatefulWidget {
  CreateCarnivalPage({Key key, this.title}) : super(key: key);
  static const routeName = '/createCarnival';
  final String title; // private variable
  @override
  _CreateCarnivalPageState createState() => _CreateCarnivalPageState();
}

class _CreateCarnivalPageState extends State<CreateCarnivalPage> {
  final _eventFormKey = GlobalKey<FormState>();
  final _formResult = CreateCarnival();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // The leading close button to quit
          leading: CloseButton(
            color: Colors.white,
          ),
          title: Text(widget.title),
          actions: [
            ElevatedButton(
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
            autovalidateMode: AutovalidateMode.always,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                // "Faschingsname" form
                TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      icon: Icon(Icons.sports_bar_outlined),
                      labelText: 'Faschingsname',
                      hintText: 'Wie heißt der Fasching?'),
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  initialValue: _formResult.eventName,
                  validator: (eventName) {
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  onSaved: (eventName) => _formResult.eventName = eventName,
                ),

                SizedBox(height: 16),

                // "Standort" form
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Standort *',
                    hintText: 'Wo findet der Fasching statt?',
                    icon: Icon(Icons.location_on_outlined),
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  initialValue: _formResult.eventLocation,
                  validator: (eventLocation) {
                    if (eventLocation.isEmpty) {
                      return 'Ungültiger Standort';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  onSaved: (eventLocation) =>
                      _formResult.eventLocation = eventLocation,
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
    }
  }

  TextEditingController _date = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: const Locale("de", "DE"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
        helpText: 'Wähle ein Datum');
    if (picked != null && picked != _formResult.eventDate)
      setState(() {
        _formResult.eventDate = picked;
        _date.value = TextEditingValue(
            text: formatDate(picked, [dd, '.', mm, '.', yyyy]));
      });
  }
}
