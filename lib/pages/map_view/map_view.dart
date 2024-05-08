import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 5,
          target: LatLng(31, 31),
        ),
      ),
    );
  }
}
