import 'dart:io';

class Place {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;

  const Place({
    required this.id,
    required this.title,
    required this.image,
    required this.location,
  });

  Place copyWith({
    String? id,
    String? title,
    File? image,
    PlaceLocation? location,
  }) {
    return Place(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      location: location ?? this.location,
    );
  }
}

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}
