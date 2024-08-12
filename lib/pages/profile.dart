import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ui_1/models/response/Customer_Idx_Get_response';
import 'package:http/http.dart' as http;
import 'package:flutter_ui_1/config/config.dart';
import 'package:flutter/widgets.dart';

class ProfilePageState extends StatefulWidget {
  ProfilePageState({super.key, required this.idx});
  int idx = 0;

  @override
  State<ProfilePageState> createState() => ProfilePageStateState();
}

class ProfilePageStateState extends State<ProfilePageState> {
  late CustomerIdGetResponse customer;
  late Future<void> loadData;
  String url ='';
  TextEditingController fullnameCtl = TextEditingController();
  TextEditingController phone2Ctl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController imageCtl = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData = loadDataAsync();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลส่วนตัว'),
        actions: [
          PopupMenuButton<String>(
onSelected: (value) {
  if (value == 'delete') {
	showDialog(
	  context: context,
	  builder: (context) => SimpleDialog(
		children: [
		  const Padding(
			padding: EdgeInsets.all(16.0),
			child: Text(
			  'ยืนยันการยกเลิกสมาชิก?',
			  style: TextStyle(
				  fontSize: 14, fontWeight: FontWeight.bold),
			),
		  ),
		  Row(
			mainAxisAlignment: MainAxisAlignment.spaceAround,
			children: [
			  TextButton(
				  onPressed: () {
					Navigator.pop(context);
				  },
				  child: const Text('ปิด')),
			  FilledButton(
				  onPressed: delete child: const Text('ยืนยัน'))
			],
		  ),
		],
	  ),
	);
  }
},
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('ยกเลิกสมาชิก'),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          if(snapshot.connectionState != ConnectionState.done){
              return const Center(
                child:CircularProgressIndicator(),
              );
          }
          fullnameCtl.text = customer.fullname;
          phone2Ctl.text = customer.phone;
          emailCtl.text = customer.email;
          imageCtl.text = customer.image;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(width: 200, child:Image.network( customer.image)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("ชื่อ-นามสกุล"),
                      TextField(
                        controller: fullnameCtl,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("เบอร์โทรศัพท์"),
                      TextField(
                        controller: phone2Ctl,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("EMAIL"),
                      TextField(
                        controller: emailCtl,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("รูปภาพ"),
                      TextField(
                        controller: imageCtl,
                      )
                    ],
                  ),
                ),
              FilledButton(
              onPressed: update,
              child: const Text('บันทึกข้อมูล'))
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
    var url = value['apiEndpoint'];
    var data = await http.get(Uri.parse('$url/customers/${widget.idx}'));
    customer = customerIdGetResponseFromJson(data.body);
  }



  void update() async {
    var json = {
    "fullname": fullnameCtl.text,
    "phone": phone2Ctl.text,
    "email": emailCtl.text,
    "image": imageCtl.text
    }; 
    Configuration config = Configuration(); 
        var value = await config.getConfig();0
    var url = value['apiEndpoint'];
    try {
      var res = await http.put(Uri.parse('$url/customers/${widget.idx}'),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: jsonEncode(json));
      var result = jsonDecode(res.body);
      // Need to know json's property by reading from API Tester
      log(result['message']);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('สำเร็จ'),
          content: const Text('บันทึกข้อมูลเรียบร้อย'),
          actions: [
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ปิด'))
          ],
        ),
      );
    } catch (err) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ผิดพลาด'),
          content: Text('บันทึกข้อมูลไม่สำเร็จ ' + err.toString()),
          actions: [
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ปิด'))
          ],
        ),
      );
    }
    

    // http.post(Uri.parse('$API_ENDPOINT/customers/login'),headers: {"Content-Type": "application/json; charset=utf-8"}, );


    var data = await http.put(Uri.parse('$url/customers/${widget.idx}'),headers: {"Content-Type": "application/json; charset=utf-8"},body:jsonEncode(json) );
    customer = customerIdGetResponseFromJson(data.body);
    
  }

  void delete() async {
       Configuration config = Configuration(); 
        var value = await config.getConfig();
      var url = value['apiEndpoint'];
  }
}




