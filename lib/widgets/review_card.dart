import 'package:flutter/material.dart';
import 'package:restaurant_app2/utils/resource/style.dart';
import 'package:restaurant_app2/data/model/restaurant_detail.dart';

// ignore: must_be_immutable
class ReviewCard extends StatelessWidget {
  CustomerReview customerReview;

  ReviewCard({Key? key, required this.customerReview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: primary,
          border: Border.all(
            width: 1,
            color: onPrimary,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 25,
                height: 20,
                decoration: BoxDecoration(
                    color: primary, borderRadius: BorderRadius.circular(15)),
                child: const Icon(Icons.account_circle,
                    size: 30, color: Colors.white),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                customerReview.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                customerReview.date,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.only(left: 40),
            child: Text(
              customerReview.review,
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
