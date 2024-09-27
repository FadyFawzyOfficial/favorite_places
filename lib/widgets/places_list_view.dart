import 'package:flutter/material.dart';

import 'place_list_tile.dart';

class PlacesListView extends StatelessWidget {
  const PlacesListView({super.key});

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => const PlaceListTile(),
    );
  }
}
