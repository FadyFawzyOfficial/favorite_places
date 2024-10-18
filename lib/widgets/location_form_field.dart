import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../models/place.dart';
import '../utils/address_getter.dart';
import '../utils/location_previewer.dart';
import '../views/map_view.dart';

class LocationFormField extends StatefulWidget {
  final void Function(PlaceLocation?) onSaved;

  const LocationFormField({super.key, required this.onSaved});

  @override
  State<LocationFormField> createState() => _LocationFormFieldState();
}

class _LocationFormFieldState extends State<LocationFormField> {
  var isGettingLocation = false;

  @override
  Widget build(context) {
    return FormField<PlaceLocation>(
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
                  : fieldState.value == null
                      ? const Text(
                          'No location chosen',
                          style: TextStyle(color: Colors.white),
                        )
                      : Image.network(
                          getLocationImage(location: fieldState.value!),
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
                onPressed: () => getLocationFromMap(fieldState: fieldState),
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

    savePlace(latitude: latitude, longitude: longitude, fieldState: filedState);
  }

  void getLocationFromMap({required FormFieldState fieldState}) async {
    setState(() => isGettingLocation = true);

    final pickedLocation = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        builder: (context) => const MapView(isPicking: true),
      ),
    );

    if (pickedLocation == null) return;

    savePlace(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      fieldState: fieldState,
    );
  }

  Future<void> savePlace({
    required double latitude,
    required double longitude,
    required FormFieldState fieldState,
  }) async {
    final address = await getAddress(latitude: latitude, longitude: longitude);

    setState(() {
      isGettingLocation = false;
      fieldState.didChange(PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: address,
      ));
    });
  }
}
