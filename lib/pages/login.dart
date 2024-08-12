import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_ui_1/config/config.dart';
import 'package:flutter_ui_1/config/internal_config.dart';
import 'package:flutter_ui_1/models/request/customer_login_post_req.dart';
import 'package:flutter_ui_1/models/response/CustomersLoginPostRespone.dart';
import 'package:flutter_ui_1/pages/register.dart';
import 'package:flutter_ui_1/pages/showTrip.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //statelass หาก build แล้ว เปลี่ยนยังไงก็ไม่สามารถเปลี่ยนได้
  String text = "";
  int count = 0;
  String Phoneno = '';
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController password = TextEditingController();
  String url='';
  // @override
  // void initState() { //initstate คือ function ทีทำงานเมื่อเปิดหน้านี้โดยทำงานหลังจาก constuctor และ 1.initstate จะทำงานครั้งเดียวเมื่อเปิดหนื้านี้ และ2.จะไม่ทำงานเมื่อเราเรียก setstate 3.มันไม่สามารถทำงานเป็น async function ได้
  //   // TODO: implement initState
  //   super.initState();
  //   Configuration config = Configuration(); //class ต้องสร้าง object ก่อนเน้อ
  //   config.getConfig().then((value){
  //     log(value['apiEndpoint']);
  //     url = (value['apiEndpoint']);
  //   },).catchError((err){
  //     log(err.toString());
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                  onDoubleTap: () {
                    log(" กดทำไมมมมมมมม ");
                  },
                  child: Image.asset('assets/images/logo.png')),
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("หมายเลขโทรศัพท์",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 20,
                            fontWeight: FontWeight.normal)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: TextField(
                        // onChanged: (Phoneno) {
                        //     log(Phoneno);
                        // },
                        controller: phoneCtl,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("รหัสผ่าน",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 20,
                            fontWeight: FontWeight.normal)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: TextField(
                        controller: password,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: register, child: Text('ลงทะเบียนใหม่')),
                  FilledButton(onPressed: Login, child: Text('เข้าสู่ระบบ'))
                ],
              ),
              Text(text)
              // Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg'),
            ],
          ),
        ));
  }

  void Login() {
    //call login api
    // var data = {"phone":"0817399999", "password":"1111"};

    //create object (request model)
    // var data = CustomerLoginPostRequest(phone:"0817399999", password:"1111");

    var data = CustomerLoginPostRequest(phone: phoneCtl.text ,password: password.text );



    //send json string of object (Model)
    http.post(Uri.parse('$API_ENDPOINT/customers/login'),headers: {"Content-Type": "application/json; charset=utf-8"}, body: customerLoginPostRequestToJson(data)).then((value){
      //Convert json string to object(Model)

       CustomersLoginPostRespone customer = customersLoginPostResponeFromJson(value.body);
      log(customer.customer.email);//-----> this is so ล้ำมากๆ เพราะเลือกได้ง่าย 
      Navigator.push(context, MaterialPageRoute(builder: (context) => Showtrip(idx: customer.customer.idx),));

      //Convert json String to Map<String, String>
      // var jsonRes = jsonDecode(value.body);
      // log(jsonRes['customer']['email']); //ทำได้ในกรณีที่รู้ว่าใน json มีอะไรบ้าง ต้องรู้โครงสร้างชัวร์ๆ
    }).catchError((eee) {
      setState(() {
              text = "Phone or password INCORRECT!!!!";
      });

    });
    // log("This login Button");
    // count++;
    // text = "log in time: $count";
    // setState(() {});
    // log(phoneCtl.text);
    // if(phoneCtl.text == '0812345678' && password.text == '1234'){
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => const Showtrip(),));
    // }
    // else if(phoneCtl.text == '0812345678' && password.text != '1234'){
    //   text = "password Incorrect";
    //   setState(() {});
    // }
    // else{
    //   text = "Phone Number Incorrect";
    //   setState(() {});
    // }


    
  }

  void register() {
    // log('this is register button');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const registerPage(),
        ));
  }
}
