import 'dart:convert';

import 'package:http/http.dart';

Future<String> getAddress({
  required double latitude,
  required double longitude,
}) async {
  final url = Uri.parse(
    'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyBjcGIyfdcyNH5mDnbhdFZi8rDhwaYuytg',
  );
  final response = await get(url);
  final responseBody = json.decode(response.body);
  final String address = responseBody['results'][0]['formatted_address'];

  return address;
}
