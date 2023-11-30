import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String reviewText;
  final String name;
  final double starRating;

  const ReviewCard({super.key,
    required this.reviewText,
    required this.name,
    required this.starRating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        color: Colors.grey.shade100,
        elevation: 6.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name: $name',
                      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 24.0,
                        ),
                        Text(
                          '$starRating',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                AutoSizeText(
                  reviewText,
                  style: const TextStyle(fontSize: 14.0),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

