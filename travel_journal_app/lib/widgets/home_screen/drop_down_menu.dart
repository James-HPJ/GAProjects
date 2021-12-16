import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../screens/add_journal_screen.dart';

class DropDownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: DropdownButton(
        icon: Icon(Icons.more_vert),
        items: [
          DropdownMenuItem(
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.exit_to_app,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('Logout')
                ],
              ),
            ),
            value: 'logout',
          ),
          DropdownMenuItem(
            child: Container(
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.plusCircle,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('Add Journal')
                ],
              ),
            ),
            value: 'addjournal',
          ),
        ],
        onChanged: (value) {
          if (value == 'logout') {
            FirebaseAuth.instance.signOut();
          }
          if (value == 'addjournal') {
            Navigator.of(context).pushNamed(AddJournalScreen.routeName);
          }
        },
      ),
    );
  }
}
