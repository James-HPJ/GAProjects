import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:travel_journal_app/models/journal.dart';

class JournalScreen extends StatelessWidget {
  static const routeName = '/journal';
  @override
  Widget build(BuildContext context) {
    final selectedJournal =
        ModalRoute.of(context).settings.arguments as Journal;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300.0,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Image.network(
                selectedJournal.profilePic,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  child: Icon(
                    FontAwesomeIcons.planeArrival,
                    size: 20.0,
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Text(
                  selectedJournal.city,
                  style: const TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Text(
                  selectedJournal.country,
                  style: const TextStyle(fontSize: 20.0, color: Colors.black38),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat.MMMd().format(selectedJournal.startDate),
                  style: const TextStyle(fontSize: 15.0, color: Colors.black38),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                const Icon(
                  FontAwesomeIcons.arrowRight,
                  size: 10.0,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Text(
                  DateFormat.yMMMd().format(selectedJournal.endDate),
                  style: const TextStyle(fontSize: 15.0, color: Colors.black38),
                ),
              ],
            ),
          ),
          Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Card(
              elevation: 6.0,
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.location_city,
                    size: 25.0,
                  ),
                ),
                title: Text(
                  selectedJournal.purpose,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(selectedJournal.inAPhrase),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            height: 150.0,
            child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: selectedJournal.photos.length,
                itemBuilder: (ctx, index) => GridTile(
                      child: Image.network(
                        selectedJournal.photos[index],
                        fit: BoxFit.cover,
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
