import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ui_1/config/config.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ui_1/models/response/Trips_Get_By_ID_Response.dart';

class TripPage extends StatefulWidget {
  //Atrribute of tripPage
  int idx = 0;
  TripPage({super.key, required this.idx});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  late TripsGetByIdResponse  trips ;
  late Future<void> loadData; //XXXXXXXXXXXXXXXXX
  String url='';
  //Atrribute of _TripPageState
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(widget.idx);// widget ตือการเชื่อมกันผ่าน class โดยวิ่งไปที่แม่มัน หรือก็คือตัวที่สืบถอดมา
  loadData = loadDataAsync();//XXXXXXXXXXXXXXXXX
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child:Column(
              children: [
                Text(trips.name),
                Text(trips.country),
                Image.network(trips.coverimage),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(trips.price.toString()),
                    Text(trips.destinationZone),
                  ],
                ),
                
                Text(trips.detail),
                Center(child: FilledButton(onPressed: () {}, child: Text("จองทริปนี้")))
              ],
            ),

          );
        }
      ),
    );
  }

    Future<void> loadDataAsync() async{ //XXXXXXXXXXXXXXXXX
    Configuration config = Configuration(); 
    // config.getConfig().then((value){
    //   log(value['apiEndpoint']);
    //   url = (value['apiEndpoint']);
    //   // getTrips();
    // },).catchError((err){
    //   log(err.toString());
    // });
    var value = await config.getConfig();
    url = value['apiEndpoint'];
    
    var data = await http.get(Uri.parse('$url/trips/${widget.idx}'));
    trips = tripsGetByIdResponseFromJson(data.body);
  }
}