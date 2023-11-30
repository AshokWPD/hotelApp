import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import '../model/ticketModel.dart';

class VendorTicketListPage extends StatefulWidget {
  const VendorTicketListPage({super.key});

  @override
  _VendorTicketListPageState createState() => _VendorTicketListPageState();
}

class _VendorTicketListPageState extends State<VendorTicketListPage> {
      final FirebaseAuth _auth = FirebaseAuth.instance;
Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);

    List<TicketModel> ticketModel = [];
bool isfetching=false;
  
   Future<void> fetchTicket() async {
              User? user = _auth.currentUser;

    // Fetch the properties and update the state
    final List<TicketModel> fetchedProperties = await getTicketHistory(user!.uid);
    setState(() {
      ticketModel = fetchedProperties;
      isfetching=true;
    });
  }
  

   void showToast(String message, var color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor:color!=Colors.black?Colors.black: Colors.white,
    );
  }
  



  
Future<List<TicketModel>> getTicketHistory(String vendorId) async {
  try {
    // Specify the Firestore collection path
    CollectionReference tickets = FirebaseFirestore.instance.collection('tickets');

    // Query the collection for tickets with the specified user ID
    QuerySnapshot querySnapshot = await tickets.where('vendorId', isEqualTo: vendorId).get();

    // Convert the query snapshot to a list of TicketModel instances
    List<TicketModel> userTickets = querySnapshot.docs
        .map((doc) => TicketModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();

    return userTickets;
  } catch (e) {
    print('Error fetching ticket history: $e');
    // Handle the error as needed
    return [];
  }
}
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTicket();
  }
  
  // List<Ticket> tickets = [
  //   Ticket(
  //     tenantName: 'John Doe',
  //     subject: 'Maintenance Request',
  //     message: 'The faucet in my apartment is leaking. Please fix it.',
  //   ),
  //   Ticket(
  //     tenantName: 'Jane Smith',
  //     subject: 'Noise Complaint',
  //     message: 'My neighbors are being too loud late at night.',
  //   ),
  //   Ticket(
  //     tenantName: 'John Doe',
  //     subject: 'Maintenance Request',
  //     message: 'The faucet in my apartment is leaking. Please fix it.',
  //   ),
  //   Ticket(
  //     tenantName: 'John Doe',
  //     subject: 'Maintenance Request',
  //     message: 'The faucet in my apartment is leaking. Please fix it.',
  //   ),
  //   Ticket(
  //     tenantName: 'John Doe',
  //     subject: 'Maintenance Request',
  //     message: 'The faucet in my apartment is leaking. Please fix it.',
  //   ),
  //   // Add more tickets as needed
  // ];

  @override
  Widget build(BuildContext context) {
        final height =MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Raised Tickets'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:isfetching? Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Flex(
                   direction: Axis.vertical,
          
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: ticketModel.length,
                    itemBuilder: (context, index) {
                      final item = ticketModel[index];
                      return Card(
                        elevation: 5.0,
                        color: Colors.grey.shade100,
                        margin: const EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          leading: Lottie.asset('images/profile.json'),
                          title: Text(
                            item.message,
                            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tenant: ${item.userName}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Message: ${item.message}',
                                style: const TextStyle(fontSize: 14.0),
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TicketDetailsPage(ticketname: item.userName, ticketmessage: item.message, tivketdec: item.description, ticketid: item.ticketId,),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ):Column(
         children: [
          SizedBox(height:height/3 ,),
           Center(
             child:  LoadingAnimationWidget.staggeredDotsWave(
            color:customColor,
            size: 50,
      ),
           ),
         ],
       )
    );
  }
}

// class Ticket {
//   final String tenantName;
//   final String subject;
//   final String message;

//   Ticket({
//     required this.tenantName,
//     required this.subject,
//     required this.message,
//   });
// }

class TicketDetailsPage extends StatelessWidget {
  final String ticketname;
  final String ticketmessage;
  final String tivketdec;
  final String ticketid;

  const TicketDetailsPage({super.key, required this.ticketname, required this.ticketmessage, required this.tivketdec, required this.ticketid,});

  Future<void> activateProperty(String ticketid) async {
  try {
    await FirebaseFirestore.instance
        .collection('tickets')
        .doc(ticketid)
        .update({'status': 'fixed'});
        showToast("Fixed Successfully", Colors.green);
  } catch (e) {
            showToast("Failed to Fix", Colors.red);

    print('Error activating property: $e');
    // Handle the error as needed
  }
}

   void showToast(String message, var color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor:color!=Colors.black?Colors.black: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Tenant: $ticketname',
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Subject: $ticketmessage',
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Message:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              tivketdec,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  activateProperty(ticketid);
                  // Implement your action here (e.g., mark as resolved, reply)
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
                  'Mark as Resolved',
                  style: TextStyle(fontSize: 16.0,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // void _resolved() {
  //   Fluttertoast.showToast(
  //     msg: 'Marked as Resolved!',
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM_RIGHT,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: Colors.grey,
  //     textColor: Colors.white,
  //     webShowClose: true,
  //     webBgColor: "linear-gradient(to right, #ffaa00, #ff7700)",
  //   );
  // }
}
