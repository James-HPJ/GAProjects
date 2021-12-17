import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:travel_journal_app/widgets/add_journal_screen/journal_image_picker.dart';

class AddJournalScreen extends StatefulWidget {
  static const routeName = '/add-journal';

  @override
  _AddJournalScreenState createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  final userId = FirebaseAuth.instance.currentUser.uid;
  bool isLoading = false;
  final _form = GlobalKey<FormState>();

  final _cityFocusNode = FocusNode();
  final _travelReasonFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  var _country;
  var _city;
  var _travelReason;
  var _description;
  var _mainPic;
  var _startDate;
  var _endDate;

  File _getImage;

  void _imagePickFn(File pickedImage) {
    _getImage = pickedImage;
  }

  void _saveForm() async {
    setState(() {
      isLoading = true;
    });

    final isValid = _form.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        _form.currentState.save();

        final ref = FirebaseStorage.instance
            .ref()
            .child(userId)
            .child(_city)
            .child('mainpicture' + Timestamp.now().toString() + '.jpg');

        await ref.putFile(_getImage);

        final url = await ref.getDownloadURL();

        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('journals')
            .add({
          'city': _city,
          'country': _country,
          'travelReason': _travelReason,
          'description': _description,
          'mainPic': url,
          'startDate': DateFormat.yMMMd().format(_startDate),
          'endDate': DateFormat.yMMMd().format(_endDate),
          'createdAt': Timestamp.now(),
        });

        setState(() {
          isLoading = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  _saveForm();
                },
                icon: const Icon(Icons.save))
          ],
          title: const Text('Add New Journal Entry'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
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
                  decoration:
                      const InputDecoration(labelText: 'Description of Trip'),
                  textInputAction: TextInputAction.next,
                  focusNode: _descriptionFocusNode,
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
                          if (pickedDate != null && pickedDate != _startDate) {
                            setState(() {
                              _startDate = pickedDate;
                            });
                          }
                        },
                        child: const Text('Start Date')),
                    Text(_startDate != null
                        ? DateFormat.yMMMd().format(_startDate)
                        : 'No date selected')
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
                        : 'No date selected')
                  ],
                ),
                const SizedBox(height: 8),
                JournalImagePicker(_imagePickFn),
              ],
            ),
          ),
        ));
  }
}
