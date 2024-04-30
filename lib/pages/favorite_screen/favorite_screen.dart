import 'package:flutter/material.dart';
import 'package:homey/core/provider/app_provider.dart';
import 'package:provider/provider.dart';

import '../home_screen/widgets/apartment_item.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final appProvider = Provider.of<AppProvider>(context);
    final favoriteApartments = appProvider.favorites;
    final itemCount = favoriteApartments.length;
    return Scaffold(
      backgroundColor: const Color(0xff0A1128),
      // appBar: AppBar(
      //   backgroundColor: const Color(0xff0A1128),
      //   centerTitle: true,
      //   title: Text(
      //     "Favorites ($itemCount)",
      //     style: theme.textTheme.titleMedium!.copyWith(
      //       color: const Color(0xff7DD7DF),
      //     ),
      //   ),
      // ),
      body: Column(
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
      ),
    );
  }
}
