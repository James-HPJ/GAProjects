import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_journal_app/screens/edit_journal.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../../screens/add_journal_screen.dart';

class JournalDropDown extends StatelessWidget {
  final String journalId;

  JournalDropDown({@required this.journalId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: DropdownButton(
        icon: const Icon(Icons.more_vert),
        items: [
          DropdownMenuItem(
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text('Edit Journal')
              ],
            ),
            value: 'edit',
          ),
          DropdownMenuItem(
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text('Delete Journal')
              ],
            ),
            value: 'delete',
          ),
          DropdownMenuItem(
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text('Logout')
              ],
            ),
            value: 'logout',
          ),
        ],
        onChanged: (value) {
          if (value == 'edit') {
            Navigator.of(context)
                .pushNamed(EditJournalScreen.routeName, arguments: journalId);
          }
          if (value == 'delete') {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Warning!'),
                content: const Text(
                    'The current journal will be permanently deleted'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection('journals')
                          .doc(journalId)
                          .delete();

                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
          if (value == 'logout') {
            FirebaseAuth.instance.signOut();
          }
        },
      ),
    );
  }
}
