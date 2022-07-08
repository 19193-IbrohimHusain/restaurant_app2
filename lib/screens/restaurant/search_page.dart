import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/data/model/restaurant.dart';
import 'package:restaurant_app2/provider/search_provider.dart';
import 'package:restaurant_app2/screens/restaurant/detail_page.dart';
import 'package:restaurant_app2/utils/helper/background/state_result.dart';

import '../../utils/resource/style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const routeName = 'search_page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String queries = '';
  final String pictureUrl =
      "https://restaurant-api.dicoding.dev/images/medium/";
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          backgroundColor: primary,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Consumer<SearchProvider>(
                builder: (context, state, _) {
                  return Container(
                    width: 360,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      leading: const Icon(
                        Icons.search,
                        size: 30,
                        color: primary,
                      ),
                      title: TextField(
                        controller: _controller,
                        onChanged: (String value) {
                          setState(() {
                            queries = value;
                          });
                          if (value != '') {
                            state.fetchSearchRestaurant(value);
                          }
                        },
                        cursorColor: primary,
                        decoration: const InputDecoration(
                            hintText: "Search Restaurant",
                            border: InputBorder.none),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: _searchRestaurant(context),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _searchRestaurant(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, state, _) {
        if (state.state == StateResult.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == StateResult.noData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search_off,
                  color: Colors.grey,
                  size: 80,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  state.message,
                  style: const TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],
            ),
          );
        } else if (state.state == StateResult.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants;
              return buildRestaurant(restaurant[index], context);
            },
          );
        } else if (state.state == StateResult.error) {
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
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
            ),
          );
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }

  Widget buildRestaurant(Restaurant restaurant, BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RestaurantsPage.routeName,
              arguments: restaurant.id);
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
