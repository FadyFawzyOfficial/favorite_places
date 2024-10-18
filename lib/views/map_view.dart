import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapView extends StatefulWidget {
  final bool isPicking;
  final PlaceLocation location;

  const MapView({
    super.key,
    required this.isPicking,
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  LatLng? pickedLatLng;

  @override
  Widget build(BuildContext context) {
    final latLng = LatLng(widget.location.latitude, widget.location.longitude);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isPicking ? 'Pick your Location' : 'Your Location'),
        actions: [
          if (widget.isPicking)
            IconButton(
              icon: const Icon(Icons.save_rounded),
              onPressed: () => Navigator.pop(context, pickedLatLng),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: (latLng) => setState(() => pickedLatLng = latLng),
        initialCameraPosition: CameraPosition(
          target: latLng,
          zoom: 16,
        ),
        markers: pickedLatLng == null && widget.isPicking
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: pickedLatLng ?? latLng,
                ),
              },
      ),
    );
  }
}
