// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/screens/restaurant/search_page.dart';
import 'package:restaurant_app2/utils/resource/theme.dart';
import 'package:get/get.dart';
import 'package:restaurant_app2/utils/helper/background/state_result.dart';
import 'package:restaurant_app2/provider/restaurant_provider.dart';
import 'package:restaurant_app2/widgets/restaurant_item.dart';

import '../../utils/resource/style.dart';

class ListRestaurant extends StatefulWidget {
  static const routeName = 'list_page';
  static const String listTile = 'list_page';

  const ListRestaurant({Key? key}) : super(key: key);

  @override
  State<ListRestaurant> createState() => _ListRestaurantState();
}

class _ListRestaurantState extends State<ListRestaurant> {
  bool isDark = Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: primary,
        actions: [
          Switch.adaptive(
              value: isDark,
              onChanged: (bool value) {
                setState(() {
                  isDark = value;
                  Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  ThemeService().switchTheme();
                });
              }),
          IconButton(
            icon: const Icon(Icons.search),
            color: secondary,
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
              FadeTransition;
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: 6.0,
            ),
            child: Text(
              'Recommended restaurant for you!',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Flexible(
            child: Consumer<RestaurantProvider>(
              builder: (context, value, child) {
                if (value.state == StateResult.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (value.state == StateResult.hasData) {
                  return ListView.builder(
                    itemCount: value.result.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = value.result.restaurants[index];
                      return RestaurantItem(
                          mode: context.theme.backgroundColor,
                          restaurant: restaurant);
                    },
                  );
                } else if (value.state == StateResult.noData) {
                  return Center(child: Text(value.message));
                } else if (value.state == StateResult.error) {
                  return Center(child: Text(value.message));
                } else {
                  return const Center(child: Text(''));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
