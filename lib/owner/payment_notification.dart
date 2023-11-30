import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentNotificationPage extends StatefulWidget {
  const PaymentNotificationPage({Key? key});

  @override
  State<PaymentNotificationPage> createState() => _PaymentNotificationPageState();
}

class _PaymentNotificationPageState extends State<PaymentNotificationPage> {
  final List<Tenant> tenantList = [
    Tenant('John Doe', '555-123-4567', 'john@example.com', 1000.0, '2023-09-01', '2023-09-30'),
    Tenant('Jane Smith', '555-987-6543', 'jane@example.com', 800.0, '2023-08-15', '2023-09-15'),
    Tenant('Bob Johnson', '555-555-5555', 'bob@example.com', 1200.0, '2023-09-05', '2023-10-05'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Payment List',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const PaymentList(),
    );
  }
}

class PaymentList extends StatefulWidget {
  const PaymentList({super.key});

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);
  final List<Tenant> tenantList = [
    Tenant('John Doe', '555-123-4567', 'john@example.com', 1000.0, '2023-09-01', '2023-09-30'),
    Tenant('Jane Smith', '555-987-6543', 'jane@example.com', 800.0, '2023-08-15', '2023-09-15'),
    Tenant('Bob Johnson', '555-555-5555', 'bob@example.com', 1200.0, '2023-09-05', '2023-10-05'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: tenantList.length,
              itemBuilder: (context, index) {
                final tenant = tenantList[index];
                return Card(
                  elevation: 5.0,
                  color: Colors.grey.shade100,
                  margin: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(tenant.name),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10.0),
                              Text(
                                'Phone: ${tenant.phoneNumber}',
                                style: const TextStyle(fontSize: 14.0),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Email: ${tenant.email}',
                                style: const TextStyle(fontSize: 14.0),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Rental Amount: \$${tenant.rentalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 14.0),
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showTenantInfo(context, tenant);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: customColor,
                              ),
                              const SizedBox(width: 5.0),
                              const Text(
                                'Info',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showTenantInfo(BuildContext context, Tenant tenant) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${tenant.name} Info'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Phone: ${tenant.phoneNumber}'),
              const SizedBox(height: 10,),
              Text('Email: ${tenant.email}'),
              const SizedBox(height: 10.0),
              Text('Check-In: ${tenant.checkInDate}'),
              const SizedBox(height: 10,),
              Text('Check-Out: ${tenant.checkOutDate}'),
              const SizedBox(height: 15,),
              Text('Rental Amount: \$${tenant.rentalAmount.toStringAsFixed(2)}',style: const TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showCustomToast(tenant);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color.fromRGBO(33, 37, 41, 1.0);
                        }
                        return const Color.fromRGBO(33, 84, 115, 1.0);
                      },
                    ),
                  ),
                  child: const Text(
                    'Send Alert',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCustomToast(Tenant tenant) {
    tenant.addPaymentHistory('Payment Notification');
    Fluttertoast.showToast(
      msg: 'Payment notification sent to ${tenant.name}!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      webShowClose: true,
      webBgColor: "linear-gradient(to right, #ffaa00, #ff7700)",
    );
  }
}

class Tenant {
  final String name;
  final String phoneNumber;
  final String email;
  final double rentalAmount;
  final String checkInDate;
  final String checkOutDate;
  final List<String> paymentHistory;

  Tenant(this.name, this.phoneNumber, this.email, this.rentalAmount, this.checkInDate, this.checkOutDate)
      : paymentHistory = [];

  void addPaymentHistory(String entry) {
    paymentHistory.add(entry);
  }
}

