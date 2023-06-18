// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:project_application/view/home_ui.dart';
import 'package:project_application/view/register_ui.dart';
import 'package:project_application/view/setpoint_ui.dart';
import 'package:project_application/view/show_sensordata_ui.dart';
import 'package:project_application/view/login_ui.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LoginUI(),
    ),
  );
}