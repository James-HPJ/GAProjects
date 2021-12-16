import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
// import 'package:provider/provider.dart';
// import 'package:travel_journal_app/models/journal.dart';
// import '../models/journal_entry.dart';

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
  final _startDateFocusNode = FocusNode();
  final _mainPicFocusNode = FocusNode();
  final _mainPicController = TextEditingController();

  var _city;
  var _travelReason;
  var _description;
  DateTime _startDate;
  var _mainPic;
  var _country;
  DateTime _endDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainPicFocusNode.addListener(_updateImageUrl);
  }

  void _updateImageUrl() {
    if (!_mainPicFocusNode.hasFocus) {
      setState(() {});
    }
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
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('journals')
            .add({
          'city': _city,
          'country': _country,
          'travelReason': _travelReason,
          'description': _description,
          'mainPic': _mainPic,
          'startDate': formatDate(_startDate, [mm, '-', dd, '-', yyyy]),
          'endDate': formatDate(_endDate, [mm, '-', dd, '-', yyyy]),
          'createdAt': Timestamp.now(),
        });

        setState(() {
          isLoading = false;
        });

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      }
    }
  }

  // ignore: prefer_final_fields
  // var _newProduct = Journal(
  //     profilePic: '',
  //     country: '',
  //     city: '',
  //     startDate: null,
  //     endDate: null,
  //     purpose: '',
  //     inAPhrase: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  _saveForm();
                },
                icon: Icon(Icons.save))
          ],
          title: Text('Add New Journal Entry'),
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
                  onFieldSubmitted: (_) {
                    Focus.of(context).requestFocus(_startDateFocusNode);
                  },
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
                InputDatePickerFormField(
                  fieldHintText: 'dd-mm-yyyy',
                  errorInvalidText: 'Pls enter a valid Date',
                  errorFormatText: 'Pls enter a correct Date Format',
                  fieldLabelText: 'Start Date',
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                  onDateSaved: (value) {
                    _startDate = value;
                  },
                ),
                InputDatePickerFormField(
                  errorInvalidText: 'Pls enter a valid Date',
                  errorFormatText: 'Pls enter a correct Date Format',
                  fieldLabelText: 'End Date',
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                  onDateSaved: (value) {
                    _endDate = value;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey),
                      ),
                      child: _mainPicController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(_mainPicController.text),
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _mainPicController,
                        focusNode: _mainPicFocusNode,
                        onSaved: (value) {
                          _mainPic = value;
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an ImageUrl';
                          }

                          if (!value.startsWith('http') ||
                              !value.startsWith('https')) {
                            return 'Please enter a valid URL';
                          }

                          return null;
                        },
                        onEditingComplete: () {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
