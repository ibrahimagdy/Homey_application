import 'package:google_maps_flutter/google_maps_flutter.dart';

class ApartmentModel {
  final String mainImage;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? image5;
  final String? image6;
  final String? image7;
  final String? image8;
  final String price;
  final String address;
  final String agent;
  final String propertyType;
  final String propertyArea;
  final String description;
  final String idLocation;
  final String titleLocation;
  final LatLng latLng;
  final int bedrooms;
  final int bathrooms;
  final int kitchens;

  const ApartmentModel({
    required this.mainImage,
    required this.price,
    required this.address,
    required this.agent,
    required this.propertyType,
    required this.propertyArea,
    required this.description,
    required this.bedrooms,
    required this.bathrooms,
    required this.kitchens,
    required this.idLocation,
    required this.titleLocation,
    required this.latLng,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.image6,
    this.image7,
    this.image8,
  });
}
