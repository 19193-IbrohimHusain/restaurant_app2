// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/screens/home/home_page.dart';
import 'package:restaurant_app2/utils/helper/background/state_result.dart';
import 'package:restaurant_app2/utils/resource/style.dart';
import 'package:restaurant_app2/widgets/review_card.dart';
import '../../data/api/api_service.dart';
import '../../data/model/restaurant_detail.dart';
import '../../provider/detail_provider.dart';

class RestaurantsPage extends StatelessWidget {
  static const routeName = '/restaurant_page';
  final String restaurant;
  const RestaurantsPage({Key? key, required this.restaurant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) =>
            RestaurantDetailProvider(apiService: ApiService(), id: restaurant),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: primary,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
            ),
            body: _buildRestaurant(context)));
  }

  Widget _buildRestaurant(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(builder: (context, state, _) {
      if (state.state == StateResult.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == StateResult.error) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.wifi_off,
                size: 150,
              ),
              Text(
                "Failed to Load Data \nPlease Check Your Internet Connection",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      } else if (state.state == StateResult.noData) {
        return Center(child: Text(state.message));
      } else if (state.state == StateResult.hasData) {
        return SingleChildScrollView(
            child: Column(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/medium/" +
                      state.result.restaurant.pictureId,
                )),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(state.result.restaurant.name,
                              style: Theme.of(context).textTheme.headline4),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, bottom: 5),
                          child: const FavoriteButton(),
                        ),
                      ]),
                  const Divider(color: Colors.transparent, height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_pin,
                              color: primary, size: 25),
                          const Padding(padding: EdgeInsets.only(left: 2)),
                          Text(
                            state.result.restaurant.address +
                                ", " +
                                state.result.restaurant.city,
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.yellow, size: 25),
                          Text(state.result.restaurant.rating.toString(),
                              style: GoogleFonts.openSans(fontSize: 15))
                        ],
                      )
                    ],
                  ),
                  const Divider(color: Colors.transparent),
                  Text(
                    state.result.restaurant.description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Category'),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: List.generate(
                        state.result.restaurant.categories.length, (index) {
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 15, top: 5, right: 15, bottom: 5),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primary,
                        ),
                        child: Text(
                            state.result.restaurant.categories[index].name),
                      );
                    }),
                  ),
                  const Divider(color: Colors.transparent),
                  const Text('Foods Menu'),
                  Column(
                    children: state.result.restaurant.menus.foods
                        .map((food) => Column(
                              children: [
                                Card(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const Icon(
                                        Icons.food_bank,
                                        color: primary,
                                        size: 50,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(food.name),
                                            const SizedBox(
                                                height: 10, width: 100),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ))
                        .toList(),
                  ),
                  const Divider(color: Colors.transparent),
                  const Text('Drinks Menu'),
                  Column(
                    children: state.result.restaurant.menus.drinks
                        .map((drink) => Column(
                              children: [
                                Card(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const Icon(
                                        Icons.local_drink,
                                        color: secondary,
                                        size: 50,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(drink.name),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ))
                        .toList(),
                  ),
                  const Divider(color: Colors.transparent),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Review Restaurant',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.result.restaurant.customerReviews.length,
                    itemBuilder: (BuildContext context, int index) {
                      CustomerReview currentReview =
                          state.result.restaurant.customerReviews[index];
                      return ReviewCard(
                        customerReview: currentReview,
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ));
      } else {
        return const Text("");
      }
    });
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
          color: Colors.red,
          size: 40,
        ),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Success!'),
                  content: const Text('Restaurant Added To Favorite'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'))
                  ],
                );
              });
        });
  }
}
