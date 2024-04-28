import 'package:flutter/material.dart';
import 'package:homey/pages/home_screen/models/apartments_model.dart';

class AppProvider extends ChangeNotifier {
  List<ApartmentModel> favorites = [];
  String? imageUrl;

  void addToFavorites(ApartmentModel apartmentModel) {
    favorites.add(apartmentModel);
    notifyListeners();
  }

  void removeFromFavorites(ApartmentModel apartmentModel) {
    favorites.remove(apartmentModel);
    notifyListeners();
  }

  bool isFavorite(ApartmentModel apartmentModel) {
    return favorites.contains(apartmentModel);
  }

  String? getImageUrl() {
    return imageUrl;
  }

  void updateImageUrl(String newImageUrl) {
    imageUrl = newImageUrl;
    notifyListeners();
  }
}
