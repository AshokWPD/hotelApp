import 'package:flutter/material.dart';
import 'package:hotel_app/sub_vendor/occupied_sub.dart';
import 'package:hotel_app/sub_vendor/unoccupied_sub.dart';

class VacantListPage extends StatefulWidget {
  @override
  State<VacantListPage> createState() => _VacantListPageState();
}

class _VacantListPageState extends State<VacantListPage> {
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Vacant List',style: TextStyle(color: customColor),),
            centerTitle: true,
            backgroundColor: Colors.white,
            bottom: TabBar( labelColor: customColor,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [Tab(text: 'Occupied',),Tab(text: "Unoccupied",)]),
          ),
          body:  TabBarView(children: [
            SingleChildScrollView(child: OccupiedListSub(),),
            SingleChildScrollView(child: UnoccupiedListSub()),
          ],),
        )
      ),
    );
  }
}
