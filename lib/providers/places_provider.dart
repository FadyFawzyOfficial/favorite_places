import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/place.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  void addPlace({required Place place}) async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final filename = basename(place.image.path);
    final copiedImage =
        await place.image.copy('${appDirectory.path}/$filename');
    final newPlace = place.copyWith(image: copiedImage);

    state = [newPlace, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
