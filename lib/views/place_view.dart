import 'package:flutter/material.dart';

import '../models/place.dart';

class PlaceView extends StatelessWidget {
  final Place place;

  const PlaceView({super.key, required this.place});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Image.file(
        place.image,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
