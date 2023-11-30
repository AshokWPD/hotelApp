import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LocationDateDialog extends StatefulWidget {
  const LocationDateDialog({Key? key}) : super(key: key);

  @override
  _LocationDateDialogState createState() => _LocationDateDialogState();
}

class _LocationDateDialogState extends State<LocationDateDialog> {
  double _dialogHeight = 500; // Set your preferred height
  final double _dialogWidth = 300; // Set your preferred width
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);

  List<String> locations = ['None', 'Bangalore', 'Hyderabad', 'Chennai', 'Mumbai'];
  String selectedLocation = 'None';

  List<String> budgetOptions = ['Any', 'Low', 'Medium', 'High'];
  String selectedBudget = 'Any';

  List<String> preferredOptions = ['Any', '1', '2', '3'];
  String selectedPreferred = 'Any';

  List<String> genderOptions = ['Any', 'Male', 'Female', 'Other'];
  String selectedGender = 'Any';

  DateTime? checkInDate;
  DateTime? checkOutDate;

  TextEditingController checkInDateController = TextEditingController();
  TextEditingController checkOutDateController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context,
      TextEditingController controller, {
        bool isMonth = false,
        bool isYear = false,
      }) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate.subtract(
        isYear ? const Duration(days: 365 * 10) : const Duration(days: 365),
      ),
      lastDate: currentDate.add(
        isYear ? const Duration(days: 365 * 10) : const Duration(days: 365),
      ),
      initialDatePickerMode: isYear ? DatePickerMode.year : DatePickerMode.day,
    );

    if (picked != null) {
      final formattedDate = isYear
          ? DateFormat('yyyy').format(picked)
          : isMonth
          ? DateFormat('MM/yyyy').format(picked)
          : DateFormat('dd/MM/yyyy').format(picked);
      controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        height: _dialogHeight,
        width: _dialogWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DropdownButtonFormField<String>(
                            value: selectedLocation,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedLocation = newValue!;
                              });
                            },
                            items: locations.map((String location) {
                              return DropdownMenuItem<String>(
                                value: location,
                                child: Text(location),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              icon: Icon(Icons.location_on, color: customColor),
                              labelText: 'Location',
                              labelStyle: TextStyle(color: customColor, fontSize: 22),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: customColor),
                              ),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: selectedPreferred,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPreferred = newValue!;
                              });
                            },
                            items: preferredOptions.map((String rating) {
                              return DropdownMenuItem<String>(
                                value: rating,
                                child: Text(rating),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              icon: Icon(Icons.group, color: customColor),
                              labelText: 'Sharing Preference',
                              labelStyle: TextStyle(color: customColor, fontSize: 22),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: customColor),
                              ),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: selectedBudget,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedBudget = newValue!;
                              });
                            },
                            items: budgetOptions.map((String budget) {
                              return DropdownMenuItem<String>(
                                value: budget,
                                child: Text(budget),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              icon: Icon(Icons.monetization_on, color: customColor),
                              labelText: 'Budget',
                              labelStyle: TextStyle(color: customColor, fontSize: 22),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: customColor),
                              ),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: selectedGender,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedGender = newValue!;
                              });
                            },
                            items: genderOptions.map((String gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              icon: Icon(Icons.person, color: customColor),
                              labelText: 'Gender',
                              labelStyle: TextStyle(color: customColor, fontSize: 22),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: customColor),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _selectDate(context, checkInDateController),
                            child: TextFormField(
                              controller: checkInDateController,
                              decoration: InputDecoration(
                                labelText: 'Check-in Date',
                                hintText: 'dd/mm/yyyy',
                                labelStyle: TextStyle(color: customColor),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: customColor),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () => _selectDate(context, checkInDateController),
                                  child: Icon(Icons.calendar_today, color: customColor),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _selectDate(context, checkOutDateController),
                            child: TextFormField(
                              controller: checkOutDateController,
                              decoration: InputDecoration(
                                labelText: 'Check-out Date',
                                hintText: 'dd/mm/yyyy',
                                labelStyle: TextStyle(color: customColor),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: customColor),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () => _selectDate(context, checkOutDateController),
                                  child: Icon(Icons.calendar_today, color: customColor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              await Future.delayed(const Duration(milliseconds: 50), () {
                                setState(() {
                                  _dialogHeight = 0;
                                });
                              });
                              await Future.delayed(const Duration(milliseconds: 450));
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return const Color.fromRGBO(33, 37, 41, 1.0);
                                  }
                                  return customColor;
                                },
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search, // Use the search icon
                                  color: Colors.white, // Customize the icon color
                                ),
                                SizedBox(width: 8), // Add spacing between icon and text
                                Text(
                                  'Search',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
