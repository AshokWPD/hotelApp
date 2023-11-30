import 'package:flutter/material.dart';
import 'package:hotel_app/owner/approved_content.dart';
import 'package:hotel_app/owner/ownerCustomSwitch.dart';
import 'unapproved_content.dart'; // port your custom switch widget.

class MyPropertyApp extends StatefulWidget {
  const MyPropertyApp({super.key});

  @override
  State<MyPropertyApp> createState() => _MyPropertyAppState();
}

class _MyPropertyAppState extends State<MyPropertyApp> {
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);
// int pageindex=0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Property',style: TextStyle(color: customColor,fontSize: 25),),
            centerTitle: true,
            backgroundColor: Colors.white,
            bottom:  TabBar(
              labelColor: customColor,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
              Tab( text: 'Approved',),
             Tab(text: 'UnApproved',),
          ],),
          ),
           body: TabBarView(
            children: [
              SingleChildScrollView(child: ApprovedContent()),
              SingleChildScrollView(child: UnapprovedContent()),
            ],
          ),
          
        
        ),
      ),
    );
  }
}
