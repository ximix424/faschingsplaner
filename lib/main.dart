import 'package:fasching_app/screens/carnivals/carnivals.dart';
import 'package:fasching_app/screens/carnivals/carnivals_2.dart';
import 'package:fasching_app/screens/showCarnival/showCarnival.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'screens/createCarnival/createCarnival.dart';
import 'state/carnival_model.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (context) => CarnivalModel(),
    child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [
          const Locale('de'),
        ],
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
            accentColor: Colors.green),
        initialRoute: '/',
        routes: {
          CarnivalsPage2.routeName: (context) => CarnivalsPage2(),
          CarnivalsPage.routeName: (context) => CarnivalsPage(),
          CreateCarnivalPage.routeName: (context) =>
              CreateCarnivalPage(title: 'Neuer Fasching'),
          ShowCarnivalPage.routeName: (context) => ShowCarnivalPage()
        })));
