// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_application/services/call_api.dart';

import '../model/SensorValue.dart';

class SensorDataUI extends StatefulWidget {
  const SensorDataUI({super.key});

  @override
  State<SensorDataUI> createState() => _SensorDataUIState();
}

class _SensorDataUIState extends State<SensorDataUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ตารางแสดงข้อมูลเซนเซอร์',
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
          future: callApiGetAllSensorValue(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // ตรวจสอบว่าข้อมูลโหลดมาครบหรือยัง
              //ครบแล้ว เอาข้อมูลมาแสดงเป็นตาราง
              return Container(
                padding: EdgeInsets.all(10.0),
                child: DataInTable(
                  datalist: snapshot.data as List<SensorValue>,
                ), //DataInTable เป็น Widget ที่เราจะสร้างขึ้นมาเอง
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

//------------------------------
//สร้าง widget ตัว DataInTable
class DataInTable extends StatelessWidget {
  final List<SensorValue> datalist;
  DataInTable({super.key, required this.datalist});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 15.0,
            ),
            Text(
              'ตารางแสดงข้อมูลเซนเซอร์',
              style: GoogleFonts.kanit(
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 15.0,
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
                      'id',
                      style: GoogleFonts.kanit(),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'อัตราการไหล',
                      style: GoogleFonts.kanit(),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ระดับน้ำ',
                      style: GoogleFonts.kanit(),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'date',
                      style: GoogleFonts.kanit(),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'time',
                      style: GoogleFonts.kanit(),
                    ),
                  ),
                ],
                rows: datalist
                    .map((data) => DataRow(cells: [
                          DataCell(
                            Text(data.id.toString()),
                          ),
                          DataCell(
                            Text(data.val.toString()),
                          ),
                          DataCell(
                            Text(data.val2.toString()),
                          ),
                          DataCell(
                            Text(data.date.toString()),
                          ),
                          DataCell(
                            Text(data.time.toString()),
                          ),
                        ]))
                    .toList(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width *1.0,
            ),
          ],
        ),
      ),
    );
  }
}
