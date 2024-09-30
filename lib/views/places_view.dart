import 'package:favorite_places/views/new_place_view.dart';
import 'package:flutter/material.dart';

import '../widgets/places_list_view.dart';

class PlacesView extends StatelessWidget {
  const PlacesView({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewPlaceView()),
            ),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: const PlacesListView(),
    );
  }
}
