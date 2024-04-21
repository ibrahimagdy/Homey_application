import 'package:flutter/material.dart';
import 'package:homey/pages/details_screen/details_screen.dart';
import 'package:homey/pages/home_screen/models/apartments_model.dart';

class ApartmentItem extends StatelessWidget {
  final ApartmentModel apartmentModel;

  const ApartmentItem({super.key, required this.apartmentModel});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              DetailsScreen.routeName,
              arguments: apartmentModel,
            );
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: mediaQuery.width * 0.9,
                height: mediaQuery.height * 0.29,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: AssetImage(apartmentModel.mainImage),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Container(
                      width: mediaQuery.width * 0.085,
                      height: mediaQuery.height * 0.085,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.21),
                        shape: BoxShape.circle,
                      ),
                      child: const Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 29,
                          ),
                          Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: mediaQuery.width * 0.8,
                height: mediaQuery.height * 0.063,
                decoration: BoxDecoration(
                  color: const Color(0xffDBDFF2).withOpacity(0.80),
                  borderRadius: BorderRadius.circular(103),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        apartmentModel.price,
                        style: theme.textTheme.bodySmall!.copyWith(
                            color: const Color(0xff163A51),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        apartmentModel.address,
                        style: theme.textTheme.bodySmall!.copyWith(
                            color: const Color(0xff163A51),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: mediaQuery.height * 0.02,
        ),
      ],
    );
  }
}
