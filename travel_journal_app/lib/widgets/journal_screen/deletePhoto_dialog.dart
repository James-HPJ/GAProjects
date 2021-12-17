import 'package:flutter/material.dart';

class DeletePhotoDialog extends StatelessWidget {
  final Function deletePhoto;

  DeletePhotoDialog(this.deletePhoto);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(onPressed: deletePhoto, child: Text('Ok')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
      ],
      content: Text('Do you wish to delete selected photo?'),
    );
  }
}
