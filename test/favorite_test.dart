import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homey/core/provider/app_provider.dart';
import 'package:homey/pages/favorite_screen/favorite_screen.dart';
import 'package:homey/pages/home_screen/widgets/apartment_item.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets(
    'testing for favorite item count',
    //Arrange
    (WidgetTester tester) async {
      final appProvider = AppProvider();
      appProvider.setFavorites([]);
      //Act
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AppProvider>.value(value: appProvider),
          ],
          child: const MaterialApp(
            home: FavoriteView(),
          ),
        ),
      );
      //Assert
      expect(find.text('Favorites (${appProvider.favorites.length})'),
          findsOneWidget);
      expect(find.byType(ApartmentItem),
          findsNWidgets(appProvider.favorites.length));
    },
  );
}
