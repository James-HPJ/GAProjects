import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:travel_journal_app/widgets/add_journal_screen/journal_image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:travel_journal_app/models/journal.dart';
// import '../models/journal_entry.dart';

class EditJournalScreen extends StatefulWidget {
  static const routeName = '/edit-journal';

  @override
  State<EditJournalScreen> createState() => _EditJournalScreenState();
}

class _EditJournalScreenState extends State<EditJournalScreen> {
  final userId = FirebaseAuth.instance.currentUser.uid;
  final _form = GlobalKey<FormState>();
  var _country;
  var _city;
  var _travelReason;
  var _description;
  var _mainPic;
  var _startDate;
  var _endDate;
  var _url;

  final _cityFocusNode = FocusNode();
  final _travelReasonFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  File _getImage;

  void _imagePickFn(File pickedImage) {
    _getImage = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    var journalId = ModalRoute.of(context).settings.arguments as String;
    var journalFireStore = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('journals')
        .doc(journalId);

    void _saveForm() async {
      final isValid = _form.currentState.validate();
      FocusScope.of(context).unfocus();

      if (isValid) {
        try {
          _form.currentState.save();

          if (_getImage != null) {
            final ref = FirebaseStorage.instance
                .ref()
                .child(userId)
                .child(_city)
                .child('mainpicture' + Timestamp.now().toString() + '.jpg');

            await ref.putFile(_getImage);

            _url = await ref.getDownloadURL();
          }

          if (_startDate != null) {
            journalFireStore.update({
              'startDate': DateFormat.yMMMd().format(_startDate),
            });
          }

          if (_endDate != null) {
            journalFireStore.update({
              'endDate': DateFormat.yMMMd().format(_endDate),
            });
          }

          journalFireStore.update({
            'city': _city,
            'country': _country,
            'travelReason': _travelReason,
            'description': _description,
            'mainPic': _url,
            'createdAt': Timestamp.now(),
          });

          Navigator.pop(context);
        } catch (error) {
          print(error);
          var message = 'something went wrong, try again';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: const Icon(Icons.save))
        ],
        title: const Text('Edit Journal Entry'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('journals')
            .doc(journalId)
            .get(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var journal = snapShot.data;
          // _startDate = DateTime.parse(journal['startDate']);
          // _endDate = DateTime.parse(journal['endDate']);
          _url = journal['mainPic'];

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _form,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: journal['country'],
                    decoration: const InputDecoration(labelText: 'Country'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      Focus.of(context).requestFocus(_cityFocusNode);
                    },
                    onSaved: (value) {
                      _country = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a Country';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: journal['city'],
                    decoration: const InputDecoration(labelText: 'City'),
                    textInputAction: TextInputAction.next,
                    focusNode: _cityFocusNode,
                    onFieldSubmitted: (_) {
                      Focus.of(context).requestFocus(_travelReasonFocusNode);
                    },
                    onSaved: (value) {
                      _city = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a City';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: journal['travelReason'],
                    decoration:
                        const InputDecoration(labelText: 'Reason for Travel'),
                    textInputAction: TextInputAction.next,
                    focusNode: _travelReasonFocusNode,
                    onFieldSubmitted: (_) {
                      Focus.of(context).requestFocus(_descriptionFocusNode);
                    },
                    onSaved: (value) {
                      _travelReason = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a Purpose';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: journal['description'],
                    decoration:
                        const InputDecoration(labelText: 'Description of Trip'),
                    textInputAction: TextInputAction.next,
                    focusNode: _descriptionFocusNode,
                    // onFieldSubmitted: (_) {
                    //   Focus.of(context).requestFocus(_startDateFocusNode);
                    // },
                    onSaved: (value) {
                      _description = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a phrase';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000, 1, 1),
                              lastDate: DateTime(2025, 1, 1),
                            );
                            if (pickedDate != null &&
                                pickedDate != _startDate) {
                              setState(() {
                                _startDate = pickedDate;
                              });
                            }
                          },
                          child: const Text('Start Date')),
                      Text(_startDate != null
                          ? DateFormat.yMMMd().format(_startDate)
                          : journal['startDate'])
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000, 1, 1),
                              lastDate: DateTime(2025, 1, 1),
                            );
                            if (pickedDate != null && pickedDate != _endDate) {
                              setState(() {
                                _endDate = pickedDate;
                              });
                            }
                          },
                          child: const Text('End Date')),
                      Text(_endDate != null
                          ? DateFormat.yMMMd().format(_endDate)
                          : journal['endDate'])
                    ],
                  ),
                  const SizedBox(height: 8),
                  JournalImagePicker(_imagePickFn),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
