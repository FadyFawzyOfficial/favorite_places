import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';

import '../models/place.dart';

class LocationFormField extends StatefulWidget {
  final void Function(PlaceLocation?) onSaved;

  const LocationFormField({super.key, required this.onSaved});

  @override
  State<LocationFormField> createState() => _LocationFormFieldState();
}

class _LocationFormFieldState extends State<LocationFormField> {
  PlaceLocation? pickedLocation;
  var isGettingLocation = false;

  @override
  Widget build(context) {
    return FormField(
      onSaved: widget.onSaved,
      validator: (location) => location == null ? 'Location is required' : null,
      builder: (fieldState) => Column(
        children: [
          InputDecorator(
            decoration: InputDecoration(
              border: InputBorder.none,
              errorText: fieldState.errorText,
            ),
            child: Container(
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
                  : pickedLocation == null
                      ? const Text(
                          'No location chosen',
                          style: TextStyle(color: Colors.white),
                        )
                      : Image.network(
                          locationImage,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.location_on_rounded),
                label: const Text('Get current location'),
                onPressed: () => getCurrentLocation(filedState: fieldState),
              ),
              TextButton.icon(
                icon: const Icon(Icons.map_rounded),
                label: const Text('Set on map'),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  void getCurrentLocation({required FormFieldState filedState}) async {
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

    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    if (latitude == null || longitude == null) return;

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyBjcGIyfdcyNH5mDnbhdFZi8rDhwaYuytg',
    );
    final response = await get(url);
    final responseBody = json.decode(response.body);
    final address = responseBody['results'][0]['formatted_address'];

    setState(() {
      isGettingLocation = false;
      filedState.didChange(PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: address,
      ));
      pickedLocation = PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: address,
      );
    });
  }

  String get locationImage {
    if (pickedLocation == null) return '';

    final latitude = pickedLocation!.latitude;
    final longitude = pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=AIzaSyBENZ3UbuWCyk0FrYIG39nJU69v-sXrIs4';
  }
}
