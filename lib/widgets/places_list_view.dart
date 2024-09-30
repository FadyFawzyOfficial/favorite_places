import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/place.dart';
import '../providers/places_provider.dart';
import 'place_list_tile.dart';

class PlacesListView extends ConsumerWidget {
  const PlacesListView({super.key});

  @override
  Widget build(context, ref) {
    final places = ref.watch(placesProvider);
    return places.isEmpty
        ? const PlacesEmptyState()
        : PlacesList(places: places);
  }
}

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) => PlaceListTile(place: places[index]),
    );
  }
}

class PlacesEmptyState extends StatelessWidget {
  const PlacesEmptyState({super.key});

  @override
  Widget build(context) {
    return const Center(
      child: Text(
        'No places added yet!',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
