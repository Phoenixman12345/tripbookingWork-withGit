import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ui_1/config/internal_config.dart';
import 'package:flutter_ui_1/models/response/trips_get_res.dart';
import 'package:flutter_ui_1/pages/profile.dart'; 
import 'package:flutter_ui_1/pages/trip.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ui_1/config/config.dart';
import 'dart:developer';

class Showtrip extends StatefulWidget {
  int idx = 0;
  Showtrip({super.key, required this.idx});

  @override
  State<Showtrip> createState() => _ShowtripState();
}

class _ShowtripState extends State<Showtrip> {
    List<TripsGetResponse> trips = [];//list = [] 

    String url='';

    late Future<void> loadData; //ใช้เวลาสักพักในการเรียกค่า
    @override
  void initState() { //initstate คือ function ทีทำงานเมื่อเปิดหน้านี้โดยทำงานหลังจาก constuctor และ 1.initstate จะทำงานครั้งเดียวเมื่อเปิดหนื้านี้ และ2.จะไม่ทำงานเมื่อเราเรียก setstate 3.มันไม่สามารถทำงานเป็น async function ได้
    // // TODO: implement initState
    super.initState();
    loadData = loadDataAsync();
    // Configuration config = Configuration(); //class ต้องสร้าง object ก่อนเน้อ
    // config.getConfig().then((value){
    //   log(value['apiEndpoint']);
    //   url = (value['apiEndpoint']);
    //   // getTrips();
    // },).catchError((err){
    //   log(err.toString());
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("รายการทริป"),
          automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              log(value);        
              if (value == 'profile') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePageState(idx: widget.idx),
                ));
              } else if (value == 'logout') {
              Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Text('ข้อมูลส่วนตัว'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('ออกจากระบบ'),
              ),
            ],
          ),
        ],
        ),
        body: Container(
          child: Column(
            children: [
              Row(
                children: [
                  const Text("ปลายทาง"),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                          onPressed: ()=> getTrips(null), child: const Text('ทั้งหมด')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                          onPressed: ()=>getTrips('เอเชีย'), child: const Text('เอเชีย')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                          onPressed: ()=>getTrips('ยุโรป'), child: const Text('ยุโรป')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                          onPressed: ()=>getTrips('เอเชียตะวันออกเฉียงใต้'), child: const Text('อาเซียน')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                          onPressed: ()=>getTrips('ประเทศไทย'), child: const Text('ประเทศไทย')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                          onPressed: () {}, child: const Text('แอนตาร์กติกา')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                          onPressed: () {}, child: const Text('แอฟริกา')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                          onPressed: () {}, child: const Text('อเมริกาเหนือ')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                          onPressed: () {}, child: const Text('อเมริกาใต้')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                          onPressed: () {}, child: const Text('และออสเตรเลีย')),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: 
                  //1 create futurebuilder
                  FutureBuilder(
                    future: loadData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        children: trips.map((trip) => 
                          Card(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(trip.name,
                                    style: const TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w900)),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(trip.coverimage,
                                      width: 170.0, height: 100.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('ประเทศ '+ trip.country),
                                      Text('ระยะเวลา '+ trip.duration.toString() + " วัน"),
                                      Text("ราคา " + trip.price.toString() + "บาท"),
                                      FilledButton(
                                          onPressed: ()=>goTotripsPage(trip.idx),
                                          child: const Text('รายละเอียดเพิ่มเติม')),
                                    ],
                                  )
                                ],
                              ),
                              
                            ],
                        )),

                        ).toList(),
                      
      
                      );
                    }
                  ),
                ),
                
                
              )
            ],
          ),
        ));
  }
  //Function for loading data from api (async)
  Future<void> loadDataAsync() async{
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

    var data = await http.get(Uri.parse('$url/trips'));
    trips = tripsGetResponseFromJson(data.body);
  }


  void getTrips(String? zone){
    http.get(Uri.parse('$API_ENDPOINT/trips')).then(
      (value){
        
        trips = tripsGetResponseFromJson(value.body);
        List<TripsGetResponse> filterdTrips = [];
       if(zone != null) { 
        for (var trip in trips){
          if(trip.destinationZone == zone){ 
            filterdTrips.add(trip);
          }
        }
        trips = filterdTrips;
      }

          
        
        setState(() {});
      },
    ).catchError((err){
      log(err.toString());
    });
  }
  
  goTotripsPage(int idx) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> TripPage(idx: idx)));
  }
}

