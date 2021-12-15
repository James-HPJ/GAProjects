import 'package:flutter/material.dart';
import './journal.dart';

class Journals with ChangeNotifier {
  final List<Journal> _journalEntries = [
    Journal(
        profilePic:
            'https://a.cdn-hotels.com/gdcs/production127/d88/a5e3756e-e17b-4f77-a7e7-a938dec22e8d.jpg?impolicy=fcrop&w=800&h=533&q=medium',
        city: 'Okinawa',
        country: 'Japan',
        startDate: DateTime(2021, 1, 1),
        endDate: DateTime(2021, 1, 14),
        purpose: 'Coastal/Country Side exploration',
        inAPhrase: 'Okinawa lets you breath easy with it\'s pace of life.',
        photos: [
          'https://img.i-scmp.com/cdn-cgi/image/fit=contain,width=1098,format=auto/sites/default/files/styles/1200x800/public/d8/images/methode/2020/03/09/25f8dce4-5912-11ea-b438-8452af50d521_image_hires_160442.jpg?itok=GgxI9yc_&v=1583741091',
          'https://www.ana.co.jp/japan-travel-planner/area/okinawa/0000002/okinawa_0000002_3.jpg',
          'https://ychef.files.bbci.co.uk/976x549/p08ydblx.jpg',
          'https://miro.medium.com/max/1400/1*VMiirNxor5-knb3rU6WrsQ.jpeg',
        ]),
    Journal(
        profilePic:
            'https://media.tacdn.com/media/attractions-splice-spp-674x446/07/03/1c/9c.jpg',
        city: 'Paris',
        country: 'France',
        startDate: DateTime(2021, 2, 1),
        endDate: DateTime(2021, 2, 14),
        purpose: 'Heritage, Shopping tours',
        inAPhrase: 'An unforgettable Parisian Experience!',
        photos: [
          'https://www.telegraph.co.uk/content/dam/Travel/Destinations/Europe/France/Paris/Attractions/the-louvre-paris-getty-medium.jpg',
          'https://static01.nyt.com/images/2020/11/03/multimedia/03AroundWorld-Paris1/03AroundWorld-Paris1-mediumSquareAt3X.jpg',
          'https://images.adsttc.com/media/images/6140/8eca/f91c/81c5/5900/0177/newsletter/jad_sylla_christo_arc_de_triom_0025.jpg?1631620732',
          'https://kkhotels-ce53.kxcdn.com/wp-content/uploads/2018/12/Montmartre-Paris-at-nightfall.jpg',
        ]),
    Journal(
        profilePic:
            'https://image.jimcdn.com/app/cms/image/transf/dimension=683x10000:format=jpg/path/sb97633a4ffd1294b/image/i48e814efcd521207/version/1511195962/image.jpg',
        city: 'Maldives',
        country: 'Male',
        startDate: DateTime(2021, 3, 1),
        endDate: DateTime(2021, 3, 14),
        purpose: 'Diving Trip',
        inAPhrase: 'Mantas and more Mantas!',
        photos: [
          'https://cache.marriott.com/marriottassets/marriott/MLEWH/mlewh-wow-oceanhaven-1800-hor-wide.jpg?interpolation=progressive-bilinear&downsize=1440px:*',
          'https://media.architecturaldigest.com/photos/6032b3c9a0b9bd2edd5510d1/master/pass/Hero_Soneva%20Jani%20Chapter%20Two%20by%20Aksham%20Abdul%20Ghadir.jpg',
          'https://api.time.com/wp-content/uploads/2018/08/conrad-maldives-rangali-island-worlds-greatest-places-20181.jpg',
          'https://img.etimg.com/thumb/msid-82330294,width-1200,height-900,imgsize-1111158,overlay-etpanache/photo.jpg',
        ]),
  ];

  List<Journal> get journalEntries {
    return [..._journalEntries];
  }

  void addJournalEntry(Journal newProduct) {
    _journalEntries.insert(0, newProduct);
    notifyListeners();
  }
}
