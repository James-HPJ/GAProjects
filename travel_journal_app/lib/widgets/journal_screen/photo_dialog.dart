import 'package:flutter/material.dart';

class PhotoDialog extends StatelessWidget {
  final String photoDescription;
  final String imageUrl;

  PhotoDialog(this.imageUrl, this.photoDescription);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white60,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  photoDescription,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
