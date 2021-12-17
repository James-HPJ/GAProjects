import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_journal_app/screens/journal_screen.dart';
// import '../models/journal_entry.dart';

class JournalCarousel extends StatelessWidget {
  // final currentUser = FirebaseAuth.instance.currentUser.uid;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('journals')
      .orderBy('startDate', descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // final currentUser = FirebaseAuth.instance.currentUser.uid;
          final journalDocs = snapshot.data.docs;

          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const <Widget>[
                    Text(
                      'Your Journeys',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Icon(Icons.travel_explore),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                height: 300.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: journalDocs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(JournalScreen.routeName,
                            arguments: journalDocs[index].id);
                        print(journalDocs[index].id);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        width: 210.0,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Positioned(
                              bottom: 15.0,
                              child: Container(
                                height: 120.0,
                                width: 200.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        journalDocs[index]['city'],
                                        style: const TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      Text(
                                        journalDocs[index]['travelReason'],
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Hero(
                                    tag: journalDocs[index].id,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        journalDocs[index]['mainPic'],
                                        height: 180.0,
                                        width: 180.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.0,
                                    bottom: 10.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          journalDocs[index]['city'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Icon(
                                              FontAwesomeIcons.locationArrow,
                                              size: 10.0,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(width: 5.0),
                                            Text(
                                              journalDocs[index]['country'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
