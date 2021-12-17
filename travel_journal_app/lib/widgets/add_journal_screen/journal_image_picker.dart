import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class JournalImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;

  JournalImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<JournalImagePicker> {
  File _pickedImage;

  void _imagePicker(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final photo = await _picker.pickImage(
      source: source,
      imageQuality: 70,
    );
    final photoFile = File(photo.path);

    setState(() {
      _pickedImage = photoFile;
    });

    widget.imagePickFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: 150,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey),
          ),
          child: _pickedImage == null
              ? const Text('Enter a URL')
              : FittedBox(
                  child: Image.file(_pickedImage),
                  fit: BoxFit.contain,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {
                _imagePicker(ImageSource.camera);
              },
              icon: const Icon(Icons.camera),
              label: Text(
                'Camera',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                _imagePicker(ImageSource.gallery);
              },
              icon: const Icon(Icons.image),
              label: Text(
                'Gallery',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
