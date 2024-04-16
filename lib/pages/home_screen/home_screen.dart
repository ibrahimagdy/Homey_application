import 'package:flutter/material.dart';

import 'model/category_data.dart';

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
    return SafeArea(
      child: Column(
        children: [
          ListTile(
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
                  borderRadius: BorderRadius.circular(27),
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
                  // ListView.builder(
                  //   itemBuilder: (context, index) {
                  //     return
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
