import 'package:flutter/material.dart';

import '../models/place.dart';
import '../views/place_view.dart';

class PlaceListTile extends StatelessWidget {
  final Place place;

  const PlaceListTile({super.key, required this.place});

  @override
  Widget build(context) {
    return ListTile(
      title: Text(place.title),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlaceView(place: place)),
      ),
    );
  }
}
