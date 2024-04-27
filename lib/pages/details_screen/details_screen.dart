import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homey/core/widgets/contact_item.dart';
import 'package:homey/core/widgets/custom_apartment_details.dart';
import 'package:homey/core/widgets/custom_divider.dart';
import 'package:homey/pages/home_screen/models/apartments_model.dart';
import 'package:homey/pages/map_screen/map_screen.dart';

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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Agent",
                        style:
                            TextStyle(color: Color(0xffC6FAFF), fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Image.asset("assets/images/profile_pic.png"),
                          const SizedBox(width: 10),
                          Text(args.agent),
                        ],
                      ),
                    ],
                  ),
                ),
                const CustomDivider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Price",
                        style:
                            TextStyle(color: Color(0xffC6FAFF), fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        args.price,
                        style: const TextStyle(color: Color(0xff0096A4)),
                      ),
                    ],
                  ),
                ),
                const CustomDivider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  child: Column(
                    children: [
                      CustomApartmentDetails(
                        imageIcon: "assets/images/property_type_icon.png",
                        property: "Property Type:",
                        info: args.propertyType,
                      ),
                      CustomApartmentDetails(
                        imageIcon: "assets/images/property_size_icon.png",
                        property: "Property Area:",
                        info: args.propertyArea,
                      ),
                      CustomApartmentDetails(
                        imageIcon: "assets/images/bedroom_icon.png",
                        property: "Bedrooms:",
                        info: args.bedrooms.toString(),
                      ),
                      CustomApartmentDetails(
                        imageIcon: "assets/images/bathroom_icon.png",
                        property: "Bathrooms:",
                        info: args.bathrooms.toString(),
                      ),
                      CustomApartmentDetails(
                        imageIcon: "assets/images/kitchen_icon.png",
                        property: "Kitchens:",
                        info: args.kitchens.toString(),
                      ),
                    ],
                  ),
                ),
                const CustomDivider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Location",
                        style:
                            TextStyle(color: Color(0xffC6FAFF), fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              args.address,
                              style: const TextStyle(
                                color: Color(0xff0096A4),
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                MapScreen.routeName,
                                arguments: args,
                              );
                            },
                            child: Image.asset("assets/images/location.png"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const CustomDivider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Description",
                        style:
                            TextStyle(color: Color(0xffC6FAFF), fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        args.description,
                        style: const TextStyle(
                          color: Color(0xff0096A4),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const CustomDivider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Contacts",
                        style:
                            TextStyle(color: Color(0xffC6FAFF), fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        height: mediaQuery.height * 0.066,
                        decoration: BoxDecoration(
                          color: const Color(0xff0096A4).withOpacity(0.33),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ContactItem(
                              contactIcon: Icons.facebook,
                              contactName: "Facebook",
                            ),
                            ContactItem(
                              contactIcon: FontAwesomeIcons.whatsapp,
                              contactName: "WhatsApp",
                            ),
                            ContactItem(
                              contactIcon: Icons.email_outlined,
                              contactName: "Email",
                            ),
                            ContactItem(
                              contactIcon: Icons.phone,
                              contactName: "Phone",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}