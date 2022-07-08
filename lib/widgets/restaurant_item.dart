import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app2/data/model/restaurant.dart';
import 'package:restaurant_app2/utils/resource/style.dart';

import '../screens/restaurant/detail_page.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;
  final Color mode;

  final String pictureUrl =
      "https://restaurant-api.dicoding.dev/images/medium/";

  const RestaurantItem({Key? key, required this.restaurant, required this.mode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            RestaurantsPage.routeName,
            arguments: restaurant.id,
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: primary),
          child: Stack(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Image.network(pictureUrl + restaurant.pictureId,
                        width: 120),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(color: Colors.transparent, height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  color: secondary,
                                  size: 20,
                                ),
                                Text(restaurant.city),
                              ],
                            ),
                            const Divider(
                              color: Colors.transparent,
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 20,
                                ),
                                Text(restaurant.rating.toString())
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
