import 'package:flutter/material.dart';

class Food {
  final String photo;
  final String name;
  final String location;
  final DateTime date;
  final int price;
  final int rating;

  Food(
      {@required this.name,
      @required this.location,
      @required this.date,
      @required this.rating,
      @required this.price,
      @required this.photo});
}

class Foods with ChangeNotifier {
  final List<Food> _meals = [
    Food(
      photo:
          'https://tz-mag-media.s3.ap-southeast-1.amazonaws.com/wp-content/uploads/2019/02/27160539/109105.jpg',
      date: DateTime(2021, 1, 2),
      location: 'Okinawa',
      name: 'Ramen',
      price: 2,
      rating: 4,
    ),
    Food(
      photo:
          'https://www.adequatetravel.com/blog/wp-content/uploads/2019/09/Croissants.jpg',
      date: DateTime(2021, 2, 2),
      location: 'Paris',
      name: 'Croissant',
      price: 3,
      rating: 3,
    ),
    Food(
      photo:
          'https://image.shutterstock.com/image-photo/grilled-lobster-260nw-722444497.jpg',
      date: DateTime(2021, 3, 2),
      location: 'Maldives',
      name: 'Lobster',
      price: 5,
      rating: 3,
    )
  ];

  List<Food> get meals {
    return [..._meals];
  }
}
