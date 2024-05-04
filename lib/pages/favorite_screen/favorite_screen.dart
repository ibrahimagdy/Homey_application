import 'package:flutter/material.dart';
import 'package:homey/core/provider/app_provider.dart';
import 'package:provider/provider.dart';

import '../home_screen/widgets/apartment_item.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final favoriteApartments = appProvider.favorites;
    return Scaffold(
      backgroundColor: const Color(0xff0A1128),
      body: favoriteApartments.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Expanded(
                  child: ListView.builder(
                    itemCount: favoriteApartments.length,
                    itemBuilder: (context, index) {
                      final apartment = favoriteApartments[index];
                      return ApartmentItem(apartmentModel: apartment);
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: Text(
                'No Apartments Found',
                style: TextStyle(
                    color: Color(0xffC6FAFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
