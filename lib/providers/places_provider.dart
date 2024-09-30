import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/place.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super([]);

  void addPlace({required Place place}) {
    state = [...state, place];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
