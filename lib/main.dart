import 'package:faschingsplaner/screens/add/add.dart';
import 'package:faschingsplaner/screens/home/home.dart';
import 'package:faschingsplaner/screens/root.dart';
import 'package:faschingsplaner/services/authentication.dart';
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
        initialRoute: RootScreen.routeName,
        routes: {
          RootScreen.routeName: (context) =>
              RootScreen(auth: new FirebaseAuthService()),
          HomeScreen.routeName: (context) => HomeScreen(),
          AddScreen.routeName: (context) => AddScreen(),
        });
  }
}

