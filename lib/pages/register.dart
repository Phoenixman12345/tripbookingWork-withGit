import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_ui_1/config/internal_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ui_1/models/request/customer_register_post_req.dart';
import 'package:flutter_ui_1/pages/showTrip.dart';
import 'package:flutter_ui_1/pages/login.dart';
import 'package:flutter_ui_1/config/config.dart';
class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPage();
}

class _registerPage extends State<registerPage> {
    TextEditingController fullname = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController check = TextEditingController();
    String url='';
    String image="none";
      void initState() { //initstate คือ function ทีทำงานเมื่อเปิดหน้านี้โดยทำงานหลังจาก constuctor และ 1.initstate จะทำงานครั้งเดียวเมื่อเปิดหนื้านี้ และ2.จะไม่ทำงานเมื่อเราเรียก setstate 3.มันไม่สามารถทำงานเป็น async function ได้
    // TODO: implement initState
    super.initState();
    Configuration config = Configuration(); //class ต้องสร้าง object ก่อนเน้อ
    config.getConfig().then((value){
      log(value['apiEndpoint']);
      url = (value['apiEndpoint']);
    },).catchError((err){
      log(err.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    
  
    return Scaffold(
        appBar: AppBar(
          title: Text("ลงทะเบียนสมาชิกใหม่"),
        ),
        body: SingleChildScrollView(
          child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ชื่อ-นามสกุล",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal)),
                  TextField(
                controller: fullname,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1))))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("หมายเลขโทรศัพท์",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal)),
                  TextField(
                controller: phone,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1))))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal)),
                  TextField(
                controller: email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1))))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("รหัสผ่าน",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal)),
                  TextField(
                    obscureText: true,
                    controller: password,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1))))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ยืนยันรหัสผ่าน",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal)),
                  TextField(
                obscureText: true,
                controller: check,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1))))
                ],
              ),
            ),
            FilledButton(onPressed: register, child: const Text('สมัครสมาชิก')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("หากมีบัญชีอยู่แล้ว"),
                TextButton(onPressed: () {} , child: const Text('เข้าสู่ระบบ')),
              ],
            ),
            
          ],
        )));
  }

  void register() {
    var data = CustomerRegisterPostRequest(fullname: fullname.text, phone: phone.text,email: email.text,image: image,password: password.text);
     
     http.post(Uri.parse('$API_ENDPOINT/customers'),headers: {"Content-Type": "application/json; charset=utf-8"}, body: customerRegisterPostRequestToJson(data)).then((value){
     log("It's OK can register");
     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));

     }).catchError((eee) {


    });

     
      
       
  }
}
