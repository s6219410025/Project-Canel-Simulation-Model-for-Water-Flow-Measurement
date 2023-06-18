// ignore_for_file: must_be_immutable, unused_import, sort_child_properties_last, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_application/services/call_api.dart';
import 'package:project_application/view/login_ui.dart';
import 'package:project_application/view/setpoint_ui.dart';
import 'package:project_application/view/show_sensordata_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/UserIot.dart';

class HomeUI extends StatefulWidget {
  UserIot? userIot;
  HomeUI({super.key, this.userIot});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  //สร้างตัวแปรประเภท UserIot เพื่อเก็บค่าที่อยู่ใน SharedPreference เพื่อนำไปใช้ในหน้าจอ
  String userId = '';
  String userName = '';
  String userFullname = '';

  //เมธอดที่ใช้ดึงค่าจาก SharePreference เพื่อนำไปใช้ในหน้าจอ
  Future<void> getDataSharePreference() async {
    //สร้างออปเจ๊กเพื่อใช้งาน SharePreference
    final prefer = await SharedPreferences.getInstance();
    //นำข้อมูลจาก SharePreference เก็บในตัวแปร
    setState(() {
      userId = prefer.getString('userId')!;
      userFullname = prefer.getString('userFullname')!;
      userName = prefer.getString('userName')!;
    });
  }

  @override
  void initState() {
    // TODO: implementy initState
    getDataSharePreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: GoogleFonts.kanit(),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFb8a4c9),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 187, 215, 244),
              Color(0xFFf5ccd4),
            ],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.15,
              ),
              Image.asset(
                'assets/images/Home.png',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Text(
                userFullname,
                style: GoogleFonts.kanit(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SensorDataUI(),
                    ),
                  );
                },
                child: Text(
                  'แสดงข้อมูลเซนเซอร์',
                  style: GoogleFonts.kanit(),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 199, 140, 238),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.7,
                    50.0,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.050,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SetpointUI(),
                    ),
                  );
                },
                child: Text(
                  'กำหนดระดับน้ำ',
                  style: GoogleFonts.kanit(),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 154, 187, 238),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.7,
                    50.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //จะต้อง key:value ทั้งหมดใน SharePreference
          //สร้างออปเจ๊ํกเพื่อใช้งาน SharePreference
          final prefer = await SharedPreferences.getInstance();
          prefer.clear();

          //แล้วกลับไปที่หน้า login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginUI(),
            ),
          );
        },
        child: Icon(
          Icons.exit_to_app,
        ),
        backgroundColor: Color.fromARGB(255, 194, 106, 119),
      ),
    );
  }
}
