import 'package:faschingsplaner/views/auth/authentication.dart';
import 'package:faschingsplaner/views/auth/authentication_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'views/add_carnival_view/add_carnival_view.dart';
import 'views/home_view/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;
  // final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Center(
        child: Text('Error occured: $_error'),
      );
    }

    if (!_initialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return MaterialApp(
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
        initialRoute: '/authentication',
        routes: {
          RootPage.routeName: (context) => RootPage(auth: new Auth()),
          HomeView.routeName: (context) => HomeView(),
          AddView.routeName: (context) => AddView(),
        });
  }
}

