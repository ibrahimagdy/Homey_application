import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../home_screen/models/apartments_model.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = "map";

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as ApartmentModel;
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              googleMapController = controller;
              setState(() {
                markers.add(
                  Marker(
                    markerId: MarkerId(args.idLocation),
                    position: args.latLng,
                  ),
                );
              });
            },
            initialCameraPosition: CameraPosition(
              target: args.latLng,
              zoom: 18,
            ),
            markers: markers,
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Color(0xff0A1128),
                size: 36,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
