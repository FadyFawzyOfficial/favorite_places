import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/place.dart';

const dbName = 'places.db';
const placesTable = 'user_places';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();
    final db = await openDatabase(
      join(dbPath, dbName),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $placesTable(id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)'),
      version: 1,
    );

    return db;
  }

  void addPlace({required Place place}) async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final filename = basename(place.image.path);
    final copiedImage =
        await place.image.copy('${appDirectory.path}/$filename');
    final newPlace = place.copyWith(image: copiedImage);

    print(newPlace.toMap());

    final db = await database;

    db.insert(placesTable, newPlace.toMap());

    state = [newPlace, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
