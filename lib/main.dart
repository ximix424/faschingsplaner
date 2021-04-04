import 'package:faschingsplaner/views/add_carnival_view/add_carnival_view.dart';
import 'package:faschingsplaner/views/auth/authentication.dart';
import 'package:faschingsplaner/views/auth/authentication_view.dart';
import 'package:faschingsplaner/views/home_view/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Faschingsplaner',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [
          const Locale('de'),
        ],
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
          accentColor: Colors.blue,
        ),
        initialRoute: RootPage.routeName,
        routes: {
          RootPage.routeName: (context) => RootPage(auth: new Auth()),
          HomeView.routeName: (context) => HomeView(),
          AddView.routeName: (context) => AddView(),
        });
  }
}

