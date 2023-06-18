// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_application/services/call_api.dart';
import 'package:project_application/view/home_ui.dart';
import 'package:project_application/view/register_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/UserIot.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  bool pWordNotShow = true;

  //สร้าง controlloer เพื่อเก็บ username/password ที่ป้อนจาก TextField
  TextEditingController userNameCtrl = TextEditingController(text: '');
  TextEditingController userPasswordCtrl = TextEditingController(text: '');

  //สร้างเมธอด เก็บสถานะการ login แบบ SharedPreference
  Future<void> setLoginStatus(UserIot userIot) async {
    //สร้างออปเจ๊กเพื่อใช้งาน SharedPreference
    final prefer = await SharedPreferences.getInstance();
    //นำออปเจ็กที่สร้างไว้ไปเก็บค่าลง SharedPreference
    //     key      ,  value ค่าที่เก็บอยู่ในkey
    prefer.setString('loginStatus', '1');
    prefer.setString('userId', userIot.userId!);
    prefer.setString('userName', userIot.userName!);
    prefer.setString('userPassword', userIot.userPassword!);
    prefer.setString('userFullname', userIot.userFullname!);
  }

  //สร้างเมธอด เช็คสถานะการ login ที่เก็บไว้แบบ SharedPreference
  Future<void> checkLoginStatus() async {
    //สร้างออปเจ๊กเพื่อใช้งาน SharedPreference
    final prefer = await SharedPreferences.getInstance();
    //ตรวจสอบว่า key : loginStatus มีไหม
    if (prefer.containsKey('loginStatus') == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeUI(),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOGIN',
          style: GoogleFonts.kanit(),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFb8a4c9),
      ),
      body: SingleChildScrollView(
        child: Container(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Image.asset(
                  'assets/images/login.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                  ),
                  child: TextField(
                    controller: userNameCtrl,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'ชื่อผู้ใช้',
                      labelStyle: GoogleFonts.kanit(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'username',
                      hintStyle: GoogleFonts.kanit(
                        color: Color.fromARGB(255, 149, 149, 149),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.05,
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                  ),
                  child: TextField(
                    controller: userPasswordCtrl,
                    obscureText: pWordNotShow,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'รหัสผ่าน',
                      labelStyle: GoogleFonts.kanit(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'password',
                      hintStyle: GoogleFonts.kanit(
                        color: Color.fromARGB(255, 149, 149, 149),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            pWordNotShow = !pWordNotShow;
                          });
                        },
                        // ternary operator --->   _________ ? _______ : ________
                        icon: pWordNotShow
                            ? Icon(
                                Icons.visibility_off,
                                color: Colors.grey[400],
                              )
                            : Icon(
                                Icons.visibility,
                                color: Colors.grey[400],
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                ElevatedButton(
                  onPressed: () async {
                    //1. validate (ตรวจสอบ) ค่าที่ป้อนก่อน แล้ว MSG เตือน

                    if (userNameCtrl.text.trim().length == 0) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'คำเตือน',
                            style: GoogleFonts.kanit(),
                          ),
                          content: Text(
                            'ป้อนชื่อผู้ใช้ด้วย',
                            style: GoogleFonts.kanit(),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'ตกลง',
                                style: GoogleFonts.kanit(),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (userPasswordCtrl.text.trim().length == 0) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'คำเตือน',
                            style: GoogleFonts.kanit(),
                          ),
                          content: Text(
                            'ป้อนรหัสผ่านด้วย',
                            style: GoogleFonts.kanit(),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'ตกลง',
                                style: GoogleFonts.kanit(),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      //2. เอา username/pasword ที่ป้อนมาแพ็กเป็น json แล้วส่งไปให้ apiLoginUser.php
                      //เพื่อตรวจสอบ แล้วเช็คผลจากการเรียกใช้ api ถ้า username/pasword ไม่ถูกต้องให้แสดง MSG
                      //แต่ถ้าถูกต้องให้ไปหน้า HomeUI()
                      UserIot? userIot = await callApiLoginUser(userNameCtrl.text.trim(), userPasswordCtrl.text.trim());
                      if (userIot!.message == "0") {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'คำเตือน',
                              style: GoogleFonts.kanit(),
                            ),
                            content: Text(
                              'ชื่อผู้ใช้รหัสผ่านไม่ถูกต้อง',
                              style: GoogleFonts.kanit(),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'ตกลง',
                                  style: GoogleFonts.kanit(),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        //กรณี login ผ่านเราจะเปิดไปหน้า HomeUI แต่ก่อนเปิดเราจะเก็บสถานะการ login เอาไว้ในเครื่อง
                        //เพื่อใช้ในการตรวจสอบว่าเคย login หรือยัง ถ้า login แล้วให้ไปหน้า Home เลย
                        //ในการเก็บสถานะการ login เราจะเก็บไว้ในเครื่องแบบ SharedPreference
                        //โดยสร้างเป็นเมธอดแล้วเรียกใช้
                        setLoginStatus(userIot);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            //builder: (context) => HomeUI(userIot: userIot),
                            builder: (context) => HomeUI(),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Login เข้าใช้งาน',
                    style: GoogleFonts.kanit(),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.7,
                      50.0,
                    ),
                    backgroundColor: Color(0xFFa7bdea),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.025,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InsertnewusertUI(),
                      ),
                    );
                  },
                  child: Text(
                    'ลงทะเบียน',
                    style: GoogleFonts.kanit(),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.7,
                      50.0,
                    ),
                    backgroundColor: Color(0xff1ed7b5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 1.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
