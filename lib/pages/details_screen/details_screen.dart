import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homey/pages/home_screen/models/apartments_model.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = "details";

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var args = ModalRoute.of(context)?.settings.arguments as ApartmentModel;
    return Scaffold(
      backgroundColor: const Color(0xff0A1128),
      body: Column(
        children: [
          Stack(children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Image.asset(
                args.mainImage,
                height: mediaQuery.height * 0.4,
                width: mediaQuery.width,
                fit: BoxFit.fill,
              ),
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
          ]),
        ],
      ),
    );
  }
}
