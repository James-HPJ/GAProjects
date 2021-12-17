import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;
  UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  @override
  File _pickedImage;

  void _imagePicker() async {
    final ImagePicker _picker = ImagePicker();
    final photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    final photoFile = File(photo.path);
    setState(() {
      _pickedImage = photoFile;
    });

    widget.imagePickFn(_pickedImage);
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        TextButton.icon(
          onPressed: _imagePicker,
          icon: Icon(Icons.camera),
          label: Text(
            'Take a picture',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
