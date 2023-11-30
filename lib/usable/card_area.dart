import 'package:flutter/material.dart';

class CardData {
  final String imagePath;
  final String title;
  final IconData? icon;
  final String? content;

  CardData({
    required this.title,
    this.imagePath = '',
    this.icon,
    this.content,
  });
}

class CardArea extends StatefulWidget {
  final List<CardData> cardDataList;

  const CardArea({super.key, required this.cardDataList});

  @override
  State<CardArea> createState() => _CardAreaState();
}

class _CardAreaState extends State<CardArea> {
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Container(
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var cardData in widget.cardDataList)
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Card(
                    elevation: 6.0,
                      color: Colors.grey.shade200,
                    child: Column(
                      children: [
                        if (cardData.imagePath.isNotEmpty)
                          Image(
                            image: AssetImage(cardData.imagePath),
                            height: 200, // Adjust the height as needed
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        if (cardData.icon != null)
                          Icon(
                            cardData.icon,
                            size: 80, // Adjust the icon size as needed
                            color: customColor,
                          ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            cardData.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20, // Adjust the font size as needed
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (cardData.content != null)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              cardData.content!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15, // Adjust the font size as needed
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
