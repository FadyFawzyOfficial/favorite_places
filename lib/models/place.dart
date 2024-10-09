import 'dart:io';

class Place {
  final String id;
  final String title;
  final File image;

  const Place({
    required this.id,
    required this.title,
    required this.image,
  });
}
