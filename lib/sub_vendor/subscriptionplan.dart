import 'package:flutter/material.dart';

class SubscriptionPlansPage extends StatefulWidget {
  const SubscriptionPlansPage({super.key});

  @override
  _SubscriptionPlansPageState createState() => _SubscriptionPlansPageState();
}

class _SubscriptionPlansPageState extends State<SubscriptionPlansPage> {
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);
  List<SubscriptionCardModel> subscriptionCards = [
    SubscriptionCardModel(
      title: 'Basic Plan',
      description: 'Access to standard room bookings',
      price: '\$9.99/month',
    ),
    SubscriptionCardModel(
      title: 'Premium Plan',
      description: 'Access to premium room bookings',
      price: '\$19.99/month',
    ),
    SubscriptionCardModel(
      title: 'Super Premium Plan',
      description: 'Access to VIP resort bookings',
      price: '\$29.99/month',
    ),
    SubscriptionCardModel(
      title: 'Custom Plan',
      description: 'Tailored to your booking needs',
      price: 'Contact us',
    ),
  ];

  bool isEditMode = false;
  int? selectedCardIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Plans'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: subscriptionCards.length,
                itemBuilder: (context, index) {
                  final cardModel = subscriptionCards[index];
                  return SubscriptionCard(
                    cardModel: cardModel,
                    isEditable: isEditMode && index == selectedCardIndex,
                    onEdit: (updatedCardModel) {
                      setState(() {
                        subscriptionCards[index] = updatedCardModel;
                      });
                    },
                    onDelete: () {
                      setState(() {
                        subscriptionCards.removeAt(index);
                        if (index == selectedCardIndex) {
                          selectedCardIndex = null;
                        }
                      });
                    },
                    onSelect: () {
                      setState(() {
                        selectedCardIndex = index;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0, right: 20),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              isEditMode = !isEditMode; // Toggle edit mode
              selectedCardIndex = null; // Deselect any selected card
            });
          },
          child: Icon(
            isEditMode ? Icons.check : Icons.edit,
            color: isEditMode ? Colors.black : Colors.white, // Change the icon color here
          ),
          backgroundColor: isEditMode ? Colors.green.shade300 : customColor,
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatefulWidget {
  final SubscriptionCardModel cardModel;
  final bool isEditable;
  final Function(SubscriptionCardModel) onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSelect;

  const SubscriptionCard({super.key,
    required this.cardModel,
    required this.isEditable,
    required this.onEdit,
    required this.onDelete,
    required this.onSelect,
  });

  @override
  _SubscriptionCardState createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.cardModel.title);
    _descriptionController = TextEditingController(text: widget.cardModel.description);
    _priceController = TextEditingController(text: widget.cardModel.price);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect, // Select this card when tapped
      child: Container(
        height: 200.0,
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: widget.isEditable && widget.isEditable ? Colors.grey.withOpacity(0.5) : Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade50.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Card(
          color: Colors.transparent,
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (widget.isEditable)
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    )
                  else
                    Text(
                      widget.cardModel.title,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  const SizedBox(height: 15.0),
                  if (widget.isEditable)
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    )
                  else
                    Text(
                      widget.cardModel.description,
                      style: const TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  const SizedBox(height: 15.0),
                  if (widget.isEditable)
                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                      ),
                    )
                  else
                    Text(
                      'Price: ${widget.isEditable ? _priceController.text : '\$***'}',
                      style:  TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: customColor,
                      ),
                    ),
                  const SizedBox(height: 15.0),
                  if (!widget.isEditable)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: widget.onDelete,
                          child: const Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubscriptionCardModel {
  String title;
  String description;
  String price;

  SubscriptionCardModel({
    this.title = '',
    this.description = '',
    this.price = '',
  });
}
