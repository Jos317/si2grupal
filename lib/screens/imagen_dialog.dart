import 'package:flutter/material.dart';

class ImagenDialog extends StatelessWidget {
  final String link;
  const ImagenDialog(this.link, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        panEnabled: false,
        boundaryMargin: EdgeInsets.all(100),
        minScale: 1,
        maxScale: 2,
          child: Image.network(
            link, 
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
      ),
    );
  }
}
