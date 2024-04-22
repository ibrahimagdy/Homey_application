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
  int currentImage = 0;

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
    ].where((image) => image != null).toList();

    return Scaffold(
      backgroundColor: const Color(0xff0A1128),
      body: Column(
        children: [
          Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: mediaQuery.height * 0.4,
                  viewportFraction: 1.0,
                  onPageChanged: (index, _) {
                    setState(() {
                      currentImage = index;
                    });
                  },
                ),
                items: images.map((image) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    child: Image.asset(
                      image!,
                      height: mediaQuery.height * 0.4,
                      width: mediaQuery.width,
                      fit: BoxFit.fill,
                    ),
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
              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  width: mediaQuery.width * 0.15,
                  height: mediaQuery.height * 0.05,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xff0A1128).withOpacity(0.54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "${currentImage + 1}/${images.length}",
                      style: const TextStyle(
                        color: Color(0xff0096A4),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}