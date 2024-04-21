import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homey/pages/home_screen/models/apartments_model.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = "details";

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var args = ModalRoute.of(context)?.settings.arguments as ApartmentModel;
    List<String?> images = [
      args.mainImage,
      args.image1,
      args.image2,
      args.image3,
      args.image4,
      args.image5,
      args.image6,
      args.image7,
      args.image8,
    ];
    return Scaffold(
      backgroundColor: const Color(0xff0A1128),
      body: Column(
        children: [
          Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: mediaQuery.height * 0.4,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                ),
                items: images.where((image) => image != null).map((image) {
                  return Image.asset(
                    image!,
                    height: mediaQuery.height * 0.4,
                    width: mediaQuery.width,
                    fit: BoxFit.fill,
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    size: 42,
                    color: Color(0xff14213D),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  color: const Color(0xff0A1128).withOpacity(0.54),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
