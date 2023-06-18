import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_application/view/home_ui.dart';
import 'package:project_application/view/login_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/UserIot.dart';
import '../services/call_api.dart';

class InsertnewusertUI extends StatefulWidget {
  const InsertnewusertUI({super.key});

  @override
  State<InsertnewusertUI> createState() => _InsertnewusertUIState();
}

class _InsertnewusertUIState extends State<InsertnewusertUI> {
  bool pWordNotShow = true;
  //สร้าง controllore เก็บ User/password ที่ป้อนจาก textField
  TextEditingController userNameCtrl = TextEditingController(text: '');
  TextEditingController userPasswordCtrl = TextEditingController(text: '');
  TextEditingController userFullnameCtrl = TextEditingController(text: '');
//สร้างเมธอด เก็บสถานะ Register
  Future<void> setInsertNewUserStatus(UserIot userIot) async {
    //
    final prefer = await SharedPreferences.getInstance();
    //นำออปเจ็กที่สร้างไว้ไปเก็บค่าลง SharedPreferences
    prefer.setString('InsertnewuserStatus', '1');
    prefer.setString('userId', userIot.userId!);
    prefer.setString('userName', userIot.userName!);
    prefer.setString('userPassword', userIot.userPassword!);
    prefer.setString('userFullname', userIot.userFullname!);
  }

  Future<void> checkInsertnewuserStatus() async {
    //สร้างออปเจคเพื่อใช้งาน SharedPreferences
    final Prefer = await SharedPreferences.getInstance();
    // ตรวจสอบว่า key loginStatus มีไหม
    if (Prefer.containsKey('InsertnewuserStatus') == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // builder: (context) => HomeUI(),
          builder: (context) => HomeUI(),
        ),
      );
    }
  }

  @override
  void initState() {
    checkInsertnewuserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'REGISTER',
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
                  'assets/images/register.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                    top: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: TextField(
                    controller: userFullnameCtrl,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'UserFullname',
                      labelStyle: GoogleFonts.kanit(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'UserFullname',
                      hintStyle: GoogleFonts.kanit(
                        color: Color.fromARGB(255, 149, 149, 149),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                    top: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: TextField(
                    controller: userNameCtrl,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Username',
                      labelStyle: GoogleFonts.kanit(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'Username',
                      hintStyle: GoogleFonts.kanit(
                        color: Color.fromARGB(255, 149, 149, 149),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.06,
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
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Password',
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
                        //ternary operator -----> _____? ______: _______
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
                  height: MediaQuery.of(context).size.width * 0.050,
                ),
                ElevatedButton(
                  onPressed: () async {
                    //1. validate (ตรวจสอบ)ค่าที่ป้อน แล้วแสดง msg เตือน

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
                                "ตกลง",
                                style: GoogleFonts.kanit(),
                              ),
                            )
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
                    } else if (userFullnameCtrl.text.trim().length == 0) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'คำเตือน',
                            style: GoogleFonts.kanit(),
                          ),
                          content: Text(
                            'ป้อนชื่อนามสกุลด้วย',
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
                      //2. เอา username/password ที่ป้อนมาเป็น json แล้วส่งไปให้ apiLogin.php
                      //เพื่อตรวจสอบ แล้วเเช็คผลจากการเรียกใช้ api ถ้า username/password  ไม่ถูกต้องให้แสดง MSG
                      // แต่ถ้าถูกให้ไปหน้า  HomeUi
                      UserIot? userIot = await callApiInsertNewUser(userNameCtrl.text.trim(), userPasswordCtrl.text.trim(), userFullnameCtrl.text.trim());
                      if (userIot!.message == "0") {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'คำเตือน',
                              style: GoogleFonts.kanit(),
                            ),
                            content: Text(
                              'ป้อนชื่อผู้ใช้ไม่ถูกต้อง',
                              style: GoogleFonts.kanit(),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "ตกลง",
                                  style: GoogleFonts.kanit(),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        //กรณี login ผ่าน เราจะเปิดไปหน้าHomeUI แต่ก่อนนเปิดเราจะเก็บสถานะการ login เอาไว้ในเครื่องเพื่อเอาไว้ใช้ในการตรวจสอบว่าเคย login หรือยังถ้า loginแล้วในไปหน้า Home เลย
                        //ในการเก็บสถานะ login เราจะเก็บผ่าน sheared preferences
                        setInsertNewUserStatus(userIot);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginUI(),
                          ),
                        );
                      }
                    }
                  },

                  // ignore: sort_child_properties_last
                  child: Text(
                    "Register",
                    style: GoogleFonts.kanit(),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.7,
                      50.0,
                    ),
                    backgroundColor: Color.fromARGB(255, 226, 152, 102),
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
