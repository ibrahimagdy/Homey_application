import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/map_model.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late CameraPosition initialCameraPosition;
  List<MapModel> apartments = [
    const MapModel(
      idLocation: "1",
      titleLocation: "Near from Mansoura University",
      latLng: LatLng(31.036605430944128, 31.361358885174905),
    ),
    const MapModel(
      idLocation: "2",
      titleLocation: "Near from German University",
      latLng: LatLng(29.996348671789004, 31.438558240111757),
    ),
    const MapModel(
      idLocation: "3",
      titleLocation: "Near from Alexandria University",
      latLng: LatLng(31.21002324037778, 29.91407565718379),
    ),
    const MapModel(
      idLocation: "3",
      titleLocation: "Near from Alexandria University",
      latLng: LatLng(31.21002324037778, 29.91407565718379),
    ),
    const MapModel(
      idLocation: "4",
      titleLocation: "Near from Sadat Academy",
      latLng: LatLng(29.966811431738726, 31.256733021994652),
    ),
    const MapModel(
      idLocation: "5",
      titleLocation: "Near from Fayoum University",
      latLng: LatLng(29.318981199265618, 30.83824800231381),
    ),
    const MapModel(
      idLocation: "6",
      titleLocation: "Near from Tanta University",
      latLng: LatLng(30.79412967707392, 30.99340773904518),
    ),
    const MapModel(
      idLocation: "7",
      titleLocation: "Near from KFS University",
      latLng: LatLng(31.09520834123604, 30.945486394585412),
    ),
    const MapModel(
      idLocation: "8",
      titleLocation: "Near from Menofia University",
      latLng: LatLng(30.567476924839806, 31.01079039395229),
    ),
  ];

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(31, 31),
      zoom: 5,
    );
    initMarker();
    super.initState();
  }

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
      ),
    );
  }

  void initMarker() async {
    var myMarkers = apartments
        .map(
          (apartmentModel) => Marker(
            position: apartmentModel.latLng,
            markerId: MarkerId(
              apartmentModel.idLocation.toString(),
            ),
          ),
        )
        .toSet();
    markers.addAll(myMarkers);
  }
}
