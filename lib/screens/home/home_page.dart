import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app2/screens/navbar/fav_restaurant.dart';
import 'package:restaurant_app2/screens/restaurant/list_page.dart';
import 'package:restaurant_app2/screens/navbar/profile_page.dart';
import 'package:restaurant_app2/utils/resource/style.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexBottomNav = 0;
  List<Widget> widgetOptions = [
    const ListRestaurant(),
    const FavoritePage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(indexBottomNav),
      bottomNavigationBar: SalomonBottomBar(
          selectedItemColor: primary,
          unselectedItemColor: secondary,
          onTap: (index) {
            setState(() {
              indexBottomNav = index;
            });
          },
          currentIndex: indexBottomNav,
          items: [
            SalomonBottomBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
                title: Text("Home",
                    style: GoogleFonts.openSans(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: primary))),
            SalomonBottomBarItem(
              icon: const Icon(Icons.favorite_outline_rounded),
              activeIcon: const Icon(Icons.favorite_rounded),
              title: Text("Favorite",
                  style: GoogleFonts.openSans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: primary)),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person_outline_rounded),
              activeIcon: const Icon(Icons.person_rounded),
              title: Text("Profile",
                  style: GoogleFonts.openSans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: primary)),
            ),
          ]),
    );
  }
}
