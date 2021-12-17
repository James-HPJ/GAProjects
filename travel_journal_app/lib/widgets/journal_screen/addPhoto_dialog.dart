import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddPhotoDialog extends StatelessWidget {
  final String journalId;
  final CollectionReference photosFireStore;

  AddPhotoDialog(this.journalId, this.photosFireStore);

  @override
  Widget build(BuildContext context) {
    var _image;

    var descriptionController = TextEditingController();

    void _imagePicker(ImageSource source) async {
      final ImagePicker _picker = ImagePicker();
      final photo = await _picker.pickImage(
        source: source,
        imageQuality: 65,
      );
      final photoFile = File(photo.path);

      _image = photoFile;
    }

    void _submitPhoto() async {
      final ref = FirebaseStorage.instance
          .ref()
          .child(FirebaseAuth.instance.currentUser.uid)
          .child(journalId)
          .child(Timestamp.now().toString() + '.jpg');

      await ref.putFile(_image);
      final url = await ref.getDownloadURL();

      photosFireStore.add({
        'imageUrl': url,
        'description': descriptionController.text,
      });

      Navigator.pop(context);
    }

    return AlertDialog(
      actions: [
        IconButton(
          onPressed: () {
            _imagePicker(ImageSource.camera);
          },
          icon: const Icon(FontAwesomeIcons.cameraRetro),
        ),
        IconButton(
          onPressed: () {
            _imagePicker(ImageSource.gallery);
          },
          icon: const Icon(FontAwesomeIcons.images),
        ),
        IconButton(onPressed: _submitPhoto, icon: const Icon(Icons.check))
      ],
      content: TextFormField(
        controller: descriptionController,
        decoration: const InputDecoration(labelText: 'Description'),
      ),
    );
  }
}
