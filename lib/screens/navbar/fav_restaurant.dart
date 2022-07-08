import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app2/utils/resource/style.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = 'favorite_page';
  static const String favTitle = 'fav_restaurant';
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite),
            const SizedBox(width: 5),
            Text(
              "Favorite",
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        elevation: 0,
        backgroundColor: primary,
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 5),
        height: 600,
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Text("You haven't add any restaurant",
                style: TextStyle(
                    color: primary, fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
