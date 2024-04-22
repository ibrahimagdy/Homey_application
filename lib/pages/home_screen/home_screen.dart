import 'package:flutter/material.dart';
import 'package:homey/pages/home_screen/models/apartments_model.dart';
import 'package:homey/pages/home_screen/widgets/apartment_item.dart';

import 'models/category_data.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var name = ModalRoute.of(context)!.settings.arguments as String;
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    List<CategoryModel> categories = [
      CategoryModel(
          categoryName: "All", categoryImage: "assets/images/all_pic.png"),
      CategoryModel(
          categoryName: "Rooms", categoryImage: "assets/images/rooms_pic.png"),
      CategoryModel(
          categoryName: "Apartments",
          categoryImage: "assets/images/apartments_pic.png"),
    ];
    List<ApartmentModel> apartments = [
      const ApartmentModel(
        mainImage: "assets/images/m1/m2.jpeg",
        price: "4100 EGP/month",
        address: "Cairo,5th settlement",
        image1: "assets/images/m1/m1.jpeg",
        image2: "assets/images/m1/m3.jpeg",
        image3: "assets/images/m1/m4.jpeg",
        image4: "assets/images/m1/m5.jpeg",
        image5: "assets/images/m1/m9.jpeg",
        image6: "assets/images/m1/m6.jpeg",
        image7: "assets/images/m1/m7.jpeg",
        image8: "assets/images/m1/m8.jpeg",
      ),
      const ApartmentModel(
        mainImage: "assets/images/m5/m1.jpeg",
        price: "3650 EGP/month",
        address: "Mansoura,toshka street",
        image1: "assets/images/m5/m2.jpeg",
        image2: "assets/images/m5/m3.jpeg",
        image3: "assets/images/m5/m4.jpeg",
        image4: "assets/images/m5/m5.jpeg",
        image5: "assets/images/m5/m6.jpeg",
        image6: "assets/images/m5/m7.jpeg",
        image7: "assets/images/m5/m8.jpeg",
      ),
      const ApartmentModel(
        mainImage: "assets/images/m4/m1.jpeg",
        price: "4100 EGP/month",
        address: "Cairo,5th settlement",
        image1: "assets/images/m4/m2.jpeg",
        image2: "assets/images/m4/m3.jpeg",
        image3: "assets/images/m4/m4.jpeg",
        image4: "assets/images/m4/m5.jpeg",
        image6: "assets/images/m4/m6.jpeg",
      ),
      const ApartmentModel(
        mainImage: "assets/images/m2/m1.jpeg",
        price: "3650 EGP/month",
        address: "Mansoura,toshka street",
        image1: "assets/images/m2/m2.jpeg",
        image2: "assets/images/m2/m3.jpeg",
        image3: "assets/images/m2/m4.jpeg",
        image4: "assets/images/m2/m5.jpeg",
        image5: "assets/images/m2/m6.jpeg",
        image6: "assets/images/m2/m7.jpeg",
      ),
      const ApartmentModel(
        mainImage: "assets/images/m3/m1.jpeg",
        price: "3650 EGP/month",
        address: "Mansoura,toshka street",
        image1: "assets/images/m3/m2.jpeg",
        image2: "assets/images/m3/m3.jpeg",
        image3: "assets/images/m3/m4.jpeg",
      ),
      const ApartmentModel(
        mainImage: "assets/images/m6/m1.jpeg",
        price: "3650 EGP/month",
        address: "Mansoura,toshka street",
        image1: "assets/images/m6/m2.jpeg",
        image2: "assets/images/m6/m3.jpeg",
        image3: "assets/images/m6/m4.jpeg",
        image4: "assets/images/m6/m5.jpeg",
        image5: "assets/images/m6/m6.jpeg",
      ),
      const ApartmentModel(
        mainImage: "assets/images/m7/m1.jpeg",
        price: "3650 EGP/month",
        address: "Mansoura,toshka street",
        image1: "assets/images/m7/m2.jpeg",
        image2: "assets/images/m7/m3.jpeg",
        image3: "assets/images/m7/m4.jpeg",
        image4: "assets/images/m7/m5.jpeg",
        image5: "assets/images/m7/m6.jpeg",
        image6: "assets/images/m7/m7.jpeg",
        image7: "assets/images/m7/m8.jpeg",
      ),
      const ApartmentModel(
        mainImage: "assets/images/m8/m1.jpeg",
        price: "3650 EGP/month",
        address: "Mansoura,toshka street",
        image1: "assets/images/m8/m2.jpeg",
        image2: "assets/images/m8/m3.jpeg",
        image3: "assets/images/m8/m4.jpeg",
        image4: "assets/images/m8/m5.jpeg",
        image5: "assets/images/m8/m6.jpeg",
      ),
    ];
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListTile(
              leading: Image.asset("assets/images/profile_pic.png"),
              title: Text(
                "Hi, $name",
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              trailing: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  "assets/images/notification.png",
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 22),
            child: TextField(
              onChanged: (value) {
                //setState(() {
                //searchQuery = value;
                //});
              },
              style: theme.textTheme.bodyMedium!.copyWith(
                color: const Color(0xff0A1128),
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffC6FAFF),
                hintText: "Search...",
                hintStyle: theme.textTheme.bodyMedium!.copyWith(
                  color: const Color(0xff0A1128),
                ),
                prefixIcon: Image.asset("assets/images/search_icon.png"),
                suffixIcon: Image.asset("assets/images/filter_icon.png"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? const Color(0xff7DD7DF) : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 5),
                        CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              AssetImage(categories[index].categoryImage),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          categories[index].categoryName,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: mediaQuery.height * 0.04),
          Expanded(
            child: Container(
              height: mediaQuery.height * 0.2,
              width: mediaQuery.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff6BC4CC),
                    Color(0xff5EACB6),
                    Color(0xff5397A3),
                    Color(0xff47818F),
                    Color(0xff3A6979),
                    Color(0xff2F4E66),
                    Color(0xff222F50),
                    Color(0xff0A1128),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Top Property",
                          style: theme.textTheme.bodyLarge,
                        ),
                        SizedBox(
                          width: mediaQuery.width * 0.01,
                        ),
                        Text(
                          "View all",
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: apartments.length,
                      itemBuilder: (context, index) {
                        return ApartmentItem(
                          apartmentModel: apartments[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
