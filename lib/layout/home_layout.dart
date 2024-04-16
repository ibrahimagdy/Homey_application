import 'package:flutter/material.dart';
import 'package:homey/pages/favorite_screen/favorite_screen.dart';
import 'package:homey/pages/home_screen/home_screen.dart';
import 'package:homey/pages/map_screen/map_screen.dart';
import 'package:homey/pages/profile_screen/profile_screen.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "home";

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIndex = 0;
  List<Widget> screens = [
    const HomeView(),
    const MapView(),
    const FavoriteView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A1128),
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff80D9E1),
              Color(0xff62A6B4),
              Color(0xff467689),
              Color(0xff2C4B62),
              Color(0xff14213D),
            ],
          ),
        ),
        child: SizedBox(
          height: 75,
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/home_icon.png"),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/map_icon.png"),
                ),
                label: "Map",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/fav_icon.png"),
                ),
                label: "Favorite",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/profile_icon.png"),
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffC6FAFF),
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Color(0xff0A1128),
          size: 45,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
