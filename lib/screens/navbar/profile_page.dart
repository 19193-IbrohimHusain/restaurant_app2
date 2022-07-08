// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app2/utils/resource/style.dart';

import '../../provider/scheduling_provider.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = 'profile_page';
  static const String profile = 'profile_page';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(
              15,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ibrohim Husain",
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '@p2314a307',
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Coming Soon!'),
                            content: const Text(
                                'This Feature Will Be Available Soon!'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'))
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget menuItem(String text) {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.openSans(
                  fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const Icon(
              Icons.chevron_right,
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Coming Soon!'),
                        content:
                            const Text('This Feature Will Be Available Soon!'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'))
                        ],
                      );
                    },
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account',
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    menuItem(
                      'Edit Profile',
                    ),
                    menuItem(
                      'Your Orders',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'General',
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    menuItem(
                      'Privacy & Policy',
                    ),
                    menuItem(
                      'Term of Service',
                    ),
                    menuItem(
                      'Help',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  'Scheduling Restaurant',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduling, _) {
                  return Switch.adaptive(
                    value: scheduling.isScheduled,
                    onChanged: (value) async {
                      scheduling.scheduledRestaurant(value);
                    },
                  );
                }),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40, top: 20),
                child: Column(
                  children: [
                    const Text(
                      "Rate This App",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Rating((rating) {})
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}

class Rating extends StatefulWidget {
  final int maxRating;
  final Function(int) onRatingSelected;
  const Rating(this.onRatingSelected, [this.maxRating = 5]);
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    final stars = List.generate(widget.maxRating, (index) {
      return GestureDetector(
        child: _ratingStar(index),
        onTap: () {
          setState(() {
            _currentRating = index + 1;
          });
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Thank You'),
                  content: const Text('Thank You For Rating This App'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'))
                  ],
                );
              });
        },
      );
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: stars,
    );
  }

  Widget _ratingStar(int index) {
    if (index < _currentRating) {
      return const Icon(
        Icons.star,
        color: Colors.yellow,
        size: 40,
      );
    } else {
      return const Icon(
        Icons.star_outline,
        size: 30,
      );
    }
  }
}
