import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_journal_app/models/food.dart';
import 'package:travel_journal_app/models/journal_entry.dart';
import 'package:travel_journal_app/screens/add_journal_screen.dart';

import 'package:travel_journal_app/screens/home_screen.dart';
import 'package:travel_journal_app/screens/journal_screen.dart';

void main() {
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
        ),
        home: HomeScreen(),
        routes: {
          JournalScreen.routeName: (ctx) => JournalScreen(),
          AddJournalScreen.routeName: (ctx) => AddJournalScreen(),
        },
      ),
    );
  }
}
