import 'package:flutter/material.dart';

class PropertySelection extends StatefulWidget {
  const PropertySelection({super.key});

  @override
  _PropertySelectionState createState() => _PropertySelectionState();
}

class _PropertySelectionState extends State<PropertySelection> {
  String selectedPropertyType = '';
  Color defaultColor = Colors.grey.shade100;
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);
  late Color selectedColor = customColor;

  void _changePropertyType(String propertyType) {
    setState(() {
      selectedPropertyType = propertyType;
    });
  }

  Widget _roomTypeButtons() {
    if (selectedPropertyType == 'Apartment') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Room Type for Apartment'),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle Apartment 1 BHK
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed) ||
                          selectedPropertyType == 'Apartment') {
                        return selectedColor;
                      }
                      return defaultColor;
                    },
                  ),
                ),
                child: Text(
                  '1 BHK',
                  style: TextStyle(
                    color: selectedPropertyType == 'Apartment'
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Apartment 2 BHK
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed) ||
                          selectedPropertyType == 'Apartment') {
                        return selectedColor;
                      }
                      return defaultColor;
                    },
                  ),
                ),
                child: Text(
                  '2 BHK',
                  style: TextStyle(
                    color: selectedPropertyType == 'Apartment'
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Apartment 3 BHK
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed) ||
                          selectedPropertyType == 'Apartment') {
                        return selectedColor;
                      }
                      return defaultColor;
                    },
                  ),
                ),
                child: Text(
                  '3 BHK',
                  style: TextStyle(
                    color: selectedPropertyType == 'Apartment'
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Other
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed) ||
                          selectedPropertyType == 'Apartment') {
                        return selectedColor;
                      }
                      return defaultColor;
                    },
                  ),
                ),
                child: Text(
                  'Other',
                  style: TextStyle(
                    color: selectedPropertyType == 'Apartment'
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else if (selectedPropertyType == 'Commercial Space') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Room Type for Commercial Space'),
          const SizedBox(height: 15),
          SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Villa VIP
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed) ||
                            selectedPropertyType == 'Commercial Space') {
                          return selectedColor;
                        }
                        return defaultColor;
                      },
                    ),
                  ),
                  child: Text(
                    'Hall',
                    style: TextStyle(
                      color: selectedPropertyType == 'Commercial Space'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Villa Luxury
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed) ||
                            selectedPropertyType == 'Commercial Space') {
                          return selectedColor;
                        }
                        return defaultColor;
                      },
                    ),
                  ),
                  child: Text(
                    'Office',
                    style: TextStyle(
                      color: selectedPropertyType == 'Commercial Space'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Villa Average
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed) ||
                            selectedPropertyType == 'Commercial Space') {
                          return selectedColor;
                        }
                        return defaultColor;
                      },
                    ),
                  ),
                  child: Text(
                    'Work Area',
                    style: TextStyle(
                      color: selectedPropertyType == 'Commercial Space'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Other
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed) ||
                            selectedPropertyType == 'Commercial Space') {
                          return selectedColor;
                        }
                        return defaultColor;
                      },
                    ),
                  ),
                  child: Text(
                    'Other',
                    style: TextStyle(
                      color: selectedPropertyType == 'Commercial Space'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (selectedPropertyType == 'Resort') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Room Type for Resort'),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle Resort Option 1
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed) ||
                          selectedPropertyType == 'Resort') {
                        return selectedColor;
                      }
                      return defaultColor;
                    },
                  ),
                ),
                child: Text(
                  'VIP',
                  style: TextStyle(
                    color: selectedPropertyType == 'Resort'
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Resort Option 2
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed) ||
                          selectedPropertyType == 'Resort') {
                        return selectedColor;
                      }
                      return defaultColor;
                    },
                  ),
                ),
                child: Text(
                  'Average',
                  style: TextStyle(
                    color: selectedPropertyType == 'Resort'
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Resort Option 3
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed) ||
                          selectedPropertyType == 'Resort') {
                        return selectedColor;
                      }
                      return defaultColor;
                    },
                  ),
                ),
                child: Text(
                  'Basic',
                  style: TextStyle(
                    color: selectedPropertyType == 'Resort'
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Other
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed) ||
                          selectedPropertyType == 'Resort') {
                        return selectedColor;
                      }
                      return defaultColor;
                    },
                  ),
                ),
                child: Text(
                  'Other',
                  style: TextStyle(
                    color: selectedPropertyType == 'Resort'
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else if (selectedPropertyType == 'PG') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Room Type for PG'),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection:  Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle PG Single Sharing
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed) ||
                            selectedPropertyType == 'PG') {
                          return selectedColor;
                        }
                        return defaultColor;
                      },
                    ),
                  ),
                  child: Text(
                    'Single Sharing',
                    style: TextStyle(
                      color: selectedPropertyType == 'PG'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    // Handle PG Dual Sharing
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed) ||
                            selectedPropertyType == 'PG') {
                          return selectedColor;
                        }
                        return defaultColor;
                      },
                    ),
                  ),
                  child: Text(
                    'Dual Sharing',
                    style: TextStyle(
                      color: selectedPropertyType == 'PG'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    // Handle PG Triple Sharing
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed) ||
                            selectedPropertyType == 'PG') {
                          return selectedColor;
                        }
                        return defaultColor;
                      },
                    ),
                  ),
                  child: Text(
                    'Triple Sharing',
                    style: TextStyle(
                      color: selectedPropertyType == 'PG'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    // Handle Other
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed) ||
                            selectedPropertyType == 'PG') {
                          return selectedColor;
                        }
                        return defaultColor;
                      },
                    ),
                  ),
                  child: Text(
                    'Other',
                    style: TextStyle(
                      color: selectedPropertyType == 'PG'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      // Return an empty Container if no property type is selected
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPropertyTypeButtons(),
        const SizedBox(height: 20,),
        _roomTypeButtons(),
      ],
    );
  }

  Widget _buildPropertyTypeButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Property Type',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _changePropertyType('Apartment');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed) ||
                          selectedPropertyType == 'Apartment') {
                        return selectedColor;
                      }
                      return defaultColor;
                    },
                  ),
                ),
                child: Text(
                  'Apartment',
                  style: TextStyle(
                    color: selectedPropertyType == 'Apartment'
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 12,),
              ElevatedButton(
                onPressed: () {
                  _changePropertyType('Commercial Space');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed) ||
                          selectedPropertyType == 'Commercial Space') {
                        return selectedColor;
                      }
                      return defaultColor;
                    },
                  ),
                ),
                child: Text(
                  'Commercial Space',
                  style: TextStyle(
                    color: selectedPropertyType == 'Commercial Space'
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 12,),
              ElevatedButton(
                onPressed: () {
                  _changePropertyType('Resort');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed) ||
                          selectedPropertyType == 'Resort') {
                        return selectedColor;
                      }
                      return defaultColor;
                    },
                  ),
                ),
                child: Text(
                  'Resort',
                  style: TextStyle(
                    color: selectedPropertyType == 'Resort'
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 12,),
              ElevatedButton(
                onPressed: () {
                  _changePropertyType('PG');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed) ||
                          selectedPropertyType == 'PG') {
                        return selectedColor;
                      }
                      return defaultColor;
                    },
                  ),
                ),
                child: Text(
                  'PG',
                  style: TextStyle(
                    color: selectedPropertyType == 'PG'
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
