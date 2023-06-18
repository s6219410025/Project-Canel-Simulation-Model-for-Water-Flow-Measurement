// วัตถุประสงค์ของไฟล์นี้
//1. ติดต่อไปยัง api ???? ที่ฝั่ง server เพื่อทำงานตามต้องการ
//2. คอยแปลงจ้อมูลฝั่ง app เป็น json ที่จะส่งไปยัง Server โดยต้องทำงานกับ model file
//3. คอยแปลงข้อมูลที่มาจาก Server ซึ่งเป็น Json ซึ่งเป็นข้อมูลที่ให้ในแอพ โดยต้องทำงานกับ model file
// import พวก model file
import 'dart:convert';
// import './../models/TempValue.dart';
// import './../models/UserIot.dart';
// import './../models/SetpointValue.dart';
//import http จาก package ที่ติดตั้งไว้
//import http จาก package ที่ติดตั้งไว้
import 'package:http/http.dart' as http;
import 'package:project_application/model/SensorValue.dart';

import '../model/SetpointValue.dart';
import '../model/UserIot.dart';

//สร้างตัวแปรเก็บ url ของ server ที่เก็บ api ที่จะเรียกใช้
//บ้าน
// String urlAPI = "https:://testmysql01.000webhostapp.com/dbread.php";
String urlAPI = "https://iotgroupa.sautechnology.com";

//มอ
//  String urlAPI = "10.1.1.62";
//บา้น

// String urlAPI = "192.168.1.106";

//สร้างเมธอด เรียกใช้ apiLoginUser.php เพื่อตรวจสอบชื่อผู้ใช้และรหัสผ่าน
Future<UserIot?> callApiLoginUser(
    String userName, String userPassword) async {
  // เอาข้อมูลที่ส่งมาจาก ui มาแพ็กรวมกัน
  UserIot userIot =
      UserIot(userName: userName, userPassword: userPassword);
  // เอาข้อมูลที่ปพ็กรวมกันแปลงเป็น JSON แล้วส่งไปที่ apiLohinUser ที่ Server
  //อย่าลืมว่าเมื่อ apiLoginUser ที่ Server ทำงานเสร็จจะส่งข้อมูลกับมาด้วย ดังนั้นเราต้องสร้างตัวแปรไว้รอรับ
  final responseData = await http.post(
    Uri.parse(urlAPI+ '/api/apiLoginUser.php'),
    body: jsonEncode(userIot),
    headers: {"Content-Type": "application/json"},
  );
// ตรวจสอบข้อมูลที่ส่งกลับมาเพื่อเอาไปใช้งาน
  if (responseData.statusCode == 200) {
    return UserIot.fromJson(await jsonDecode(responseData.body));
  } else {
    return null;
  }
}

// สร้างเมธอดเรียกใช้ apiGetAllSensorValue.php
Future<List<SensorValue>?> callApiGetAllSensorValue() async {
  //คำสั่งเรียกใช้ API ที่ Server โดยต้องสร้างตัวแปรมารองรับข้อมูลที่ Server ส่งกลับมา
  final responseData = await http.get(
    Uri.parse(urlAPI+ '/api/apiGetAllSensorValue.php'),
    headers: {"Content-Type": "application/json"},
  );

  //ตรวจสอบข้อมูลที่ส่งมา และรีเทรินข้อมูลที่ส่งมาเอาไปใช้ในแอฟพลิเคชัน
  if (responseData.statusCode == 200) {
    //แปลงข้อมูลที่ส่งมาซึ่งเป็น JSON ไปเป็นข้อมูลที่จะใช้ในแอป (คือข้อมูลแบบ list)
    final data = await jsonDecode(responseData.body);

    final sensorValue = await data.map<SensorValue>((value) {
      return SensorValue.fromJson(value);
    }).toList();

    return sensorValue;
  } else {
    return null;
  }
}

// สร้างเมธอดเรียกใช้ apiGetAllTempValur.php
Future<List<SetpointValue>?> callApiGetAllSetpointValue() async {
  //คำสั่งเรียกใช้ API ที่ Server โดยต้องสร้างตัวแปรมารองรับข้ออมูลที่ Server ส่งกลับมา
  final responseData = await http.get(
    Uri.parse(urlAPI + '/api/apiGetAllSetpointValue.php'),
    headers: {"Content-Type": "application/json"},
  );

  //ตรวจสอบข้อมูลที่ส่งมา และรีเทรินข้อมูลที่ส่งมาเอาไปใช้ในแอฟพลิเคชัน
  if (responseData.statusCode == 200) {
    //แปลงข้อมูลที่ส่งมาซึ่งเป็น JSON ไปเป็นข้อมูลที่จะใช้ในแอป (คือข้อมูลแบบ list)
    final data = await jsonDecode(responseData.body);

    final setpointValue = await data.map<SetpointValue>((value) {
      return SetpointValue.fromJson(value);
    }).toList();

    return setpointValue;
  } else {
    return null;
  }
}

//สร้างเมธอด เรียกใช้ apiInsertNewUser.phpเพื่อตรวจสอบชื่อผู้ใช้และรหัสผ่าน
Future<UserIot?> callApiInsertNewUser(
    String userName, String userPassword,String userFullname) async {
  // เอาข้อมูลที่ส่งมาจาก ui มาแพ็กรวมกัน

  UserIot userIot =
      UserIot(userName: userName, userPassword: userPassword,userFullname: userFullname);
  // เอาข้อมูลที่แพ็กรวมกันแปลงเป็น JSON แล้วส่งไปที่ apiInsertNewUser ที่ Server
  //อย่าลืมว่าเมื่อ apiLoginUser ที่ Server ทำงานเสร็จจะส่งข้อมูลกับมาด้วย ดังนั้นเราต้องสร้างตัวแปรไว้รอรับ
  final responseData = await http.post(
    Uri.parse(urlAPI+ '/api/apiInsertNewUser.php'),
    body: jsonEncode(userIot),
    headers: {"Content-Type": "application/json"},
  );
// ตรวจสอบข้อมูลที่ส่งกลับมาเพื่อเอาไปใช้งาน
  if (responseData.statusCode == 200) {
    return UserIot.fromJson(await jsonDecode(responseData.body));
  } else {
    return null;
  }
}

//สร้างเมธอด เรียกใช้ apiSetPoint.phpเพื่อตรวจสอบชื่อผู้ใช้และรหัสผ่าน
Future<SetpointValue?> callApiSetpoint(String setPoint) async {

SetpointValue setpointValue =
      SetpointValue(setPoint: setPoint);
  // เอาข้อมูลที่แพ็กรวมกันแปลงเป็น JSON แล้วส่งไปที่ apiInsertNewUser ที่ Server
  //อย่าลืมว่าเมื่อ apiLoginUser ที่ Server ทำงานเสร็จจะส่งข้อมูลกับมาด้วย ดังนั้นเราต้องสร้างตัวแปรไว้รอรับ
  final responseData = await http.post(

    Uri.parse(urlAPI+ '/api/apiSetPoint.php'),
    body: jsonEncode(setpointValue),
    headers: {"Content-Type": "application/json"},
  );
// ตรวจสอบข้อมูลที่ส่งกลับมาเพื่อเอาไปใช้งาน
  if (responseData.statusCode == 200) {
    return SetpointValue.fromJson(await jsonDecode(responseData.body));
  } else {
    return null;
  }
}
// สร้างเมธอด ...........

// สร้างเมธอด ...........
