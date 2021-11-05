import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dialog_progress.dart';


String Gambar(String namafile){
  String alamat = "assets/images/"+namafile;
  return alamat;
}

class Warna {
  static Color primary = Color(0xFFFFA50E);
  static Color secondary = Color(0xFFFFCA2A);
  static Color text = Color(0xFF777777);
  static Color white = Color(0xFFFFFFFF);
  static Color light = Color(0xFF959595);
  static Color red = Color(0xFFE75E5E);
  static Color green = Color(0xFF5DAC51);
}


double Ukuran(BuildContext context, double x) {
  double lebar = MediaQuery.of(context).size.width * x / 100;
  return lebar;
}

void toast(text, {color}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color ?? Colors.black,
      textColor: Warna.white,
      fontSize: 16.0
  );
}

showProgressDialog(context) {
  showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => DialogProgress());
}

