// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_journal_app/widgets/home_screen/drop_down_menu.dart';
import 'package:travel_journal_app/widgets/home_screen/journal_carousel.dart';
import 'package:travel_journal_app/widgets/food_carousel.dart';
import 'package:travel_journal_app/widgets/people_carousel.dart';
import '../models/travel_quotes.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String getTravelQuotes() {
    return travelQuotes[Random().nextInt(travelQuotes.length - 1)];
  }

  List<IconData> getIcons = [
    FontAwesomeIcons.locationArrow,
    FontAwesomeIcons.fish,
    FontAwesomeIcons.walking,
  ];

  List<Widget> catergories = [
    JournalCarousel(),
    FoodCarousel(),
    PeopleCarousel(),
  ];

  int _selectedIndex = 0;
  String _travelQuote;

  @override
  void initState() {
    super.initState();
    _travelQuote = getTravelQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [DropDownMenu()],
        title: const Text('My Travel Journeys'),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 5.0,
                      ),
                    ]),
                child: Image.network(
                  'https://media.cntraveler.com/photos/5fd26c4ddf72876c320b8001/16:9/w_2560%2Cc_limit/952456172',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20.0,
                left: 30.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white60,
                  ),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '\'' + _travelQuote + '\'',
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: getIcons
                .map(
                  (eachIcon) => CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedIndex = getIcons.indexOf(eachIcon);
                        });
                      },
                      icon: Icon(eachIcon),
                      iconSize: 25,
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: 10.0,
          ),
          catergories[_selectedIndex],
        ],
      ),
    );
  }
}
