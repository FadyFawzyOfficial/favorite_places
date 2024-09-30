import 'package:favorite_places/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'place_list_tile.dart';

class PlacesListView extends ConsumerWidget {
  const PlacesListView({super.key});

  @override
  Widget build(context, ref) {
    final places = ref.read(placesProvider);
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) => const PlaceListTile(),
    );
  }
}
