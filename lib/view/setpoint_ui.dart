import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_application/view/home_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_application/services/call_api.dart';

import '../model/SetpointValue.dart';

class SetpointUI extends StatefulWidget {
  const SetpointUI({super.key});

  @override
  State<SetpointUI> createState() => _SetpointUIState();
}

class _SetpointUIState extends State<SetpointUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'กำหนดระดับน้ำ',
          style: GoogleFonts.kanit(),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFb8a4c9),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
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
        child: FutureBuilder(
          future: callApiGetAllSetpointValue(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // ตรวจสอบว่าข้อมูลโหลดมาครบหรือยัง
              //ครบแล้ว เอาข้อมูลมาแสดงเป็นตาราง
              return Container(
                padding: EdgeInsets.all(10.0),
                child: DataInTable(
                  datalist: snapshot.data as List<SetpointValue>,
                ),
              );
            } else {
              //ยังไม่ครบให้ แสดงเป็น Progress หมุนๆ
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

//สร้าง widget ตัว DataInTable
class DataInTable extends StatelessWidget {
  //สร้าง controller เพื่อเก็บ username/password ที่ป้อนจาก TextField

  TextEditingController setPointCtrl = TextEditingController(text: '');

  Future<void> setSetpointStatus(SetpointValue setpointValue) async {
    final prefer = await SharedPreferences.getInstance();
    //นำออปเจ๊กที่สร้างไว้ไปเก็บค่าลง SharePreference
    //  key     ,   value ค่าที่เก็บอยู่ในkey
    prefer.setString('setpointStatus', '1');
    prefer.setString('setPoint', setpointValue.setPoint!);
  }

  //สร้างเมธอด เช็คสถานะการ login ที่เก็บไว้แบบ SharedPreference
  Future<void> checkSetpointStatus() async {
    //สร้างออปเจ๊กเพื่อใช้งาน SharedPreference
    final prefer = await SharedPreferences.getInstance();
    //ตรวจสอบว่า key : loginStatus มีไหม
    if (prefer.containsKey('setpointStatus') == true) {
      // onPressed: () {
      //    Navigator.pop(context);
      //  },
    }
  }

  final List<SetpointValue> datalist;
  DataInTable({super.key, required this.datalist});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 25.0,
            ),
            Text(
              'ตารางแสดงข้อมูลการกำหนดระดับน้ำ',
              style: GoogleFonts.kanit(
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            FittedBox(
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 26, 219, 206)),
                border: TableBorder.all(
                  width: 1.5,
                ),
                columns: [
                  DataColumn(
                    label: Text(
                      'ID',
                      style: GoogleFonts.kanit(),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Setpoint',
                      style: GoogleFonts.kanit(),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Date',
                      style: GoogleFonts.kanit(),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Time',
                      style: GoogleFonts.kanit(),
                    ),
                  ),
                ],
                rows: datalist
                    .map((data) => DataRow(cells: [
                          DataCell(
                            Text(
                              data.id.toString(),
                            ),
                          ),
                          DataCell(
                            Text(
                              data.setPoint.toString(),
                            ),
                          ),
                          DataCell(
                            Text(
                              data.setpointDate.toString(),
                            ),
                          ),
                          DataCell(
                            Text(
                              data.setpointTime.toString(),
                            ),
                          ),
                        ]))
                    .toList(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.15,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.15,
                right: MediaQuery.of(context).size.width * 0.15,
              ),
              child: TextFormField(
                controller: setPointCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'setpoint',
                  labelStyle: GoogleFonts.kanit(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'setpoint',
                  hintStyle: GoogleFonts.kanit(
                    color: Color.fromARGB(255, 161, 160, 160),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            ElevatedButton(
              onPressed: () async {
                if (setPointCtrl.text.trim().length == 0) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'คำเตือน',
                        style: GoogleFonts.kanit(),
                      ),
                      content: Text(
                        'ป้อนค่าที่ต้องการกำหนด',
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
                  SetpointValue? setpointValue = await callApiSetpoint(setPointCtrl.text.trim());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      //builder: (context) => HomeUI(userIot: userIot),
                      builder: (context) => HomeUI(),
                    ),
                  );
                }
              },
              child: Text(
                'ตกลง',
                style: GoogleFonts.kanit(),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(
                  MediaQuery.of(context).size.width * 0.7,
                  50.0,
                ),
                backgroundColor: Color.fromARGB(255, 130, 171, 202),
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
    );
  }
}