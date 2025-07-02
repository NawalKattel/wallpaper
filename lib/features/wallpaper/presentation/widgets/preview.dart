import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PreviewPage extends StatelessWidget {
  final String imageSource;
  const PreviewPage({super.key, required this.imageSource});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1,
      widthFactor: 1,
      child: Stack(
        children: [
          Positioned(top: 0,bottom: 0,left: 0,right: 0,
            child: CachedNetworkImage(imageUrl: imageSource, fit: BoxFit.cover)),
          Positioned(
            top: 40,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
