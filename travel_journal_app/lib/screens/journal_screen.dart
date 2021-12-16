import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_journal_app/widgets/journal_screen/journal_drop_down.dart';

class JournalScreen extends StatelessWidget {
  static const routeName = '/journal';
  final currentUser = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    final selectedJournalId =
        ModalRoute.of(context).settings.arguments as String;
    var journalCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('journals');

    return Scaffold(
      appBar: AppBar(
        actions: [
          JournalDropDown(journalId: selectedJournalId),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: journalCollection.doc(selectedJournalId).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var journal = snapshot.data;
                return Column(
                  children: [
                    Hero(
                      tag: selectedJournalId,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                        child: Container(
                          height: 200.0,
                          width: double.infinity,
                          child: Image.network(
                            journal['mainPic'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
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
                            journal['city'],
                            style: const TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            journal['country'],
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            journal['startDate'],
                            style: const TextStyle(
                                fontSize: 15.0, color: Colors.black38),
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
                            journal['endDate'],
                            style: const TextStyle(
                                fontSize: 15.0, color: Colors.black38),
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
                            journal['travelReason'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(journal.data()['description']),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                  ],
                );
              }),
          FutureBuilder(
            future: journalCollection
                .doc(selectedJournalId)
                .collection('photos')
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var photos = snapshot.data.docs;
              return Container(
                height: 150.0,
                child: GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: photos.length,
                    itemBuilder: (ctx, index) => GridTile(
                          child: Image.network(
                            photos[index]['imageUrl'],
                            fit: BoxFit.cover,
                          ),
                        )),
              );
            },
          ),
        ],
      ),
    );
  }
}
