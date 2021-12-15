import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_journal_app/models/journal.dart';
import '../models/journal_entry.dart';

class AddJournalScreen extends StatefulWidget {
  static const routeName = '/add-journal';
  @override
  _AddJournalScreenState createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  bool isLoading = false;
  final _form = GlobalKey<FormState>();

  final _cityFocusNode = FocusNode();
  final _purposeFocusNode = FocusNode();
  final _inAPhraseFocusNode = FocusNode();
  final _startDateFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageFocusNode.addListener(_updateImageUrl);
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    setState(() {
      isLoading = true;
    });
    _form.currentState.save();
    print(_newProduct.profilePic);
    Provider.of<Journals>(context, listen: false).addJournalEntry(_newProduct);

    setState(() {
      isLoading = false;
    });

    Navigator.of(context).pop;
  }

  // ignore: prefer_final_fields
  var _newProduct = Journal(
      profilePic: '',
      country: '',
      city: '',
      startDate: null,
      endDate: null,
      purpose: '',
      inAPhrase: '');

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
                    _newProduct = Journal(
                        profilePic: _newProduct.profilePic,
                        country: value,
                        city: _newProduct.city,
                        startDate: _newProduct.startDate,
                        endDate: _newProduct.endDate,
                        purpose: _newProduct.purpose,
                        inAPhrase: _newProduct.inAPhrase);
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
                    Focus.of(context).requestFocus(_purposeFocusNode);
                  },
                  onSaved: (value) {
                    _newProduct = Journal(
                        profilePic: _newProduct.profilePic,
                        country: _newProduct.country,
                        city: value,
                        startDate: _newProduct.startDate,
                        endDate: _newProduct.endDate,
                        purpose: _newProduct.purpose,
                        inAPhrase: _newProduct.inAPhrase);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a City';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Purpose'),
                  textInputAction: TextInputAction.next,
                  focusNode: _purposeFocusNode,
                  onFieldSubmitted: (_) {
                    Focus.of(context).requestFocus(_inAPhraseFocusNode);
                  },
                  onSaved: (value) {
                    _newProduct = Journal(
                        profilePic: _newProduct.profilePic,
                        country: _newProduct.country,
                        city: _newProduct.city,
                        startDate: _newProduct.startDate,
                        endDate: _newProduct.endDate,
                        purpose: value,
                        inAPhrase: _newProduct.inAPhrase);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a Purpose';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'In a Phrase'),
                  textInputAction: TextInputAction.next,
                  focusNode: _inAPhraseFocusNode,
                  onFieldSubmitted: (_) {
                    Focus.of(context).requestFocus(_startDateFocusNode);
                  },
                  onSaved: (value) {
                    _newProduct = Journal(
                        profilePic: _newProduct.profilePic,
                        country: _newProduct.country,
                        city: _newProduct.city,
                        startDate: _newProduct.startDate,
                        endDate: _newProduct.endDate,
                        purpose: _newProduct.purpose,
                        inAPhrase: value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a phrase';
                    }
                    return null;
                  },
                ),
                InputDatePickerFormField(
                  errorInvalidText: 'Pls enter a valid Date',
                  errorFormatText: 'Pls enter a correct Date Format',
                  fieldLabelText: 'Start Date',
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                  onDateSaved: (value) {
                    _newProduct = Journal(
                        profilePic: _newProduct.profilePic,
                        country: _newProduct.country,
                        city: _newProduct.city,
                        startDate: value,
                        endDate: _newProduct.endDate,
                        purpose: _newProduct.purpose,
                        inAPhrase: _newProduct.inAPhrase);
                  },
                ),
                InputDatePickerFormField(
                  errorInvalidText: 'Pls enter a valid Date',
                  errorFormatText: 'Pls enter a correct Date Format',
                  fieldLabelText: 'End Date',
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                  onDateSaved: (value) {
                    _newProduct = Journal(
                        profilePic: _newProduct.profilePic,
                        country: _newProduct.country,
                        city: _newProduct.city,
                        startDate: _newProduct.startDate,
                        endDate: value,
                        purpose: _newProduct.purpose,
                        inAPhrase: _newProduct.inAPhrase);
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
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageFocusNode,
                        onSaved: (value) {
                          _newProduct = Journal(
                              profilePic: value,
                              country: _newProduct.country,
                              city: _newProduct.city,
                              startDate: _newProduct.startDate,
                              endDate: _newProduct.endDate,
                              purpose: _newProduct.purpose,
                              inAPhrase: _newProduct.inAPhrase);
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
