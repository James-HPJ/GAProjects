import 'package:flutter/material.dart';

class Journal {
  final String profilePic;
  final String country;
  final String city;
  final DateTime startDate;
  final DateTime endDate;
  final String purpose;
  final String inAPhrase;
  final List<String> photos;

  Journal({
    @required this.profilePic,
    @required this.country,
    @required this.city,
    @required this.startDate,
    @required this.endDate,
    @required this.purpose,
    @required this.inAPhrase,
    this.photos,
  });
}
