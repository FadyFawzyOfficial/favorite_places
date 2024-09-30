import 'package:flutter/material.dart';

import '../models/place.dart';

class PlaceListTile extends StatelessWidget {
  final Place place;

  const PlaceListTile({super.key, required this.place});

  @override
  Widget build(context) => ListTile(title: Text(place.title));
}
