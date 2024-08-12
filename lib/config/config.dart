import 'dart:convert';

import 'package:flutter/services.dart';

class Configuration {
  Future <Map<String, dynamic>> getConfig() {
    return rootBundle.loadString('assets/config/config.json').then((value){ //return สองชั้น it's asynchronus
      return jsonDecode(value) as Map<String, dynamic>; 
      //jsondecode => convert to String
    });

  }
}