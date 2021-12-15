import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_journal_app/models/food.dart';
import 'package:travel_journal_app/models/journal_entry.dart';
import 'package:travel_journal_app/screens/add_journal_screen.dart';
import 'package:travel_journal_app/screens/auth_screen.dart';

import 'package:travel_journal_app/screens/home_screen.dart';
import 'package:travel_journal_app/screens/journal_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Journals()),
        ChangeNotifierProvider(create: (ctx) => Foods()),
      ],
      child: MaterialApp(
        title: 'Travel Journal',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          backgroundColor: Colors.teal,
          accentColor: Colors.yellow,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              primary: Colors.teal,
              onPrimary: Colors.white,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.teal,
            ),
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            }
            return AuthScreen();
          },
        ),
        routes: {
          JournalScreen.routeName: (ctx) => JournalScreen(),
          AddJournalScreen.routeName: (ctx) => AddJournalScreen(),
        },
      ),
    );
  }
}
