import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationData? location;
  var isGettingLocation = false;

  @override
  Widget build(context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: isGettingLocation
              ? const CircularProgressIndicator()
              : const Text(
                  'No location chosen',
                  style: TextStyle(color: Colors.white),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on_rounded),
              label: const Text('Get current location'),
              onPressed: getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map_rounded),
              label: const Text('Set on map'),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() => isGettingLocation = true);

    locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lng = locationData.longitude;

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyBjcGIyfdcyNH5mDnbhdFZi8rDhwaYuytg',
    );
    final response = await get(url);
    final responseBody = json.decode(response.body);
    print(responseBody);
    final address = responseBody['results'][0]['formatted_address'];

    setState(() => isGettingLocation = false);

    print(address);
  }
}
