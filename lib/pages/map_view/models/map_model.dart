import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapModel {
  final LatLng latLng;
  final String idLocation;
  final String titleLocation;

  const MapModel(
      {required this.titleLocation,
      required this.idLocation,
      required this.latLng});
}
