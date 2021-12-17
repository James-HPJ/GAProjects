import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_journal_app/widgets/journal_screen/addPhoto_dialog.dart';
import 'package:travel_journal_app/widgets/journal_screen/deletePhoto_dialog.dart';

import './photo_dialog.dart';

class PhotoGrid extends StatelessWidget {
  final String journalId;

  PhotoGrid(this.journalId);

  @override
  Widget build(BuildContext context) {
    final photosFireStore = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('journals')
        .doc(journalId)
        .collection('photos');

    void _imagePicker(ImageSource source) async {
      final ImagePicker _picker = ImagePicker();
      final photo = await _picker.pickImage(
        source: source,
        imageQuality: 65,
      );
      final photoFile = File(photo.path);

      final ref = FirebaseStorage.instance
          .ref()
          .child(FirebaseAuth.instance.currentUser.uid)
          .child(journalId)
          .child(Timestamp.now().toString() + '.jpg');

      await ref.putFile(photoFile);
      final url = await ref.getDownloadURL();

      photosFireStore.add({});
    }

    void _deletePhoto(photoId) async {
      await photosFireStore.doc(photoId).delete();
      Navigator.pop(context);
    }

    return StreamBuilder(
      stream: photosFireStore.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var photos = snapshot.data.docs;

        if (snapshot.data.docs.length == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Start adding photos from your Trip!',
                style: (TextStyle(fontWeight: FontWeight.bold)),
              ),
              AddPhotoButton(
                  journalId: journalId, photosFireStore: photosFireStore),
            ],
          );
        }
        return Column(
          children: [
            Container(
              height: 220.0,
              child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: photos.length,
                  itemBuilder: (ctx, index) => GridTile(
                        child: GestureDetector(
                          onLongPress: () => showDialog(
                            context: context,
                            builder: (_) => DeletePhotoDialog(() {
                              _deletePhoto(photos[index].id);
                            }),
                          ),
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => PhotoDialog(
                                photos[index]['imageUrl'],
                                photos[index]['description']),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              photos[index]['imageUrl'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )),
            ),
            AddPhotoButton(
                journalId: journalId, photosFireStore: photosFireStore),
          ],
        );
      },
    );
  }
}

class AddPhotoButton extends StatelessWidget {
  const AddPhotoButton({
    Key key,
    @required this.journalId,
    @required this.photosFireStore,
  }) : super(key: key);

  final String journalId;
  final CollectionReference<Map<String, dynamic>> photosFireStore;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => showDialog(
        context: context,
        builder: (_) => AddPhotoDialog(journalId, photosFireStore),
      ),
      icon: const Icon(FontAwesomeIcons.plusCircle),
      label: const Text('Add Photo'),
    );
  }
}
