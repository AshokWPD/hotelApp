import 'package:flutter/material.dart';
import 'dart:async';
import 'package:timer_builder/timer_builder.dart' show TimerBuilder;
import 'review_card.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentCustomerReviewIndex = 0;
  int currentOwnerReviewIndex = 0;
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);

  // Replace these with your actual review data
  List<Map<String, String>> customerReviews = [
    {
      'text':
      'I love this site so much so I simply want to imagine how just beautiful Everything is. Everything is great! Thanks for making this awesome so much.',
      'name': 'Emily',
      'starRating': '4.5',
    },
    {
      'text':
      'I love this site so much so I simply want to imagine how just beautiful Everything is. Everything is great! Thanks for making this awesome so much.',
      'name': 'John',
      'starRating': '2.0',
    },
    {
      'text':
      'I love this site so much so I simply want to imagine how just beautiful Everything is. Everything is great! Thanks for making this awesome so much.',
      'name': 'Peter',
      'starRating': '3.5',
    },
    // Add more customer reviews with name, profileImage, and starRating
  ];

  List<Map<String, String>> ownerReviews = [
    {
      'text':
      'I love this site so much so I simply want to imagine how just beautiful Everything is. Everything is great! Thanks for making this awesome so much.',
      'name': 'Vicky',
      'starRating': '4.0',
    },
    {
      'text':
      'I love this site so much so I simply want to imagine how just beautiful Everything is. Everything is great! Thanks for making this awesome so much.',
      'name': 'Mathew',
      'starRating': '4.0',
    },
    {
      'text':
      'I love this site so much so I simply want to imagine how just beautiful Everything is. Everything is great! Thanks for making this awesome so much.',
      'name': 'Tom',
      'starRating': '4.0',
    },
    // Add more owner reviews with name, profileImage, and starRating
  ];

  Timer? _timer; // Declare the timer as an instance variable

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 0; // Default to "Customer"

    // Start the timer
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_tabController.index == 0) {
        setState(() {
          currentCustomerReviewIndex =
              (currentCustomerReviewIndex + 1) % customerReviews.length;
        });
      } else {
        setState(() {
          currentOwnerReviewIndex =
              (currentOwnerReviewIndex + 1) % ownerReviews.length;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 200.0,
          height: 100.0,
          child: Material(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0),
                  color: Colors.grey.shade200),
                  child: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(
                        text: 'Customer',
                      ),
                      Tab(
                        text: 'Vendor',
                      ),
                    ],
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    labelColor: customColor,
                    unselectedLabelColor: Colors.black,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: const TextStyle(),
                    onTap: (index) {
                      setState(() {
                        _tabController.index = index;
                      });
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
        SizedBox(
          width: 300,
          height: 200,
          child: TimerBuilder.periodic(const Duration(seconds: 10), builder: (context) {
            return _buildReviewCard();
          }),
        ),
      ],
    );
  }

  Widget _buildReviewCard() {
    if (_tabController.index == 0) {
      final review = customerReviews[currentCustomerReviewIndex];
      return KeyedSubtree(
        key: ValueKey<int>(currentCustomerReviewIndex), // Use a ValueKey with an int
        child: ReviewCard(
          reviewText: review['text'] ?? '',
          name: review['name'] ?? '',
          starRating: double.parse(review['starRating'] ?? '0.0'),
        ),
      );
    } else {
      final review = ownerReviews[currentOwnerReviewIndex];
      return KeyedSubtree(
        key: ValueKey<int>(currentOwnerReviewIndex), // Use a ValueKey with an int
        child: ReviewCard(
          reviewText: review['text'] ?? '',
          name: review['name'] ?? '',
          starRating: double.parse(review['starRating'] ?? '0.0'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer?.cancel(); // Cancel the timer when disposing the widget
    super.dispose();
  }
}
