import 'package:favorite_places/models/place.dart';

String getLocationImage({required PlaceLocation location}) {
  final latitude = location.latitude;
  final longitude = location.longitude;
  return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=AIzaSyBENZ3UbuWCyk0FrYIG39nJU69v-sXrIs4';
}
