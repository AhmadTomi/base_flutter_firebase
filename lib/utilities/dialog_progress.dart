import 'dart:ui';

import 'package:base_flutter_firebase/utilities/tools.dart';
import 'package:flutter/material.dart';
import 'aniload.dart';

class DialogProgress extends StatefulWidget {
  @override
  _DialogProgressState createState() => _DialogProgressState();
}

class _DialogProgressState extends State<DialogProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(90),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        height: Ukuran(context, 35),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           Text("Tunggu Sebentar ...",style: TextStyle(color: Warna.text),),
            SizedBox(height: Ukuran(context, 5),),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: AniLoad(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _animationController.dispose();
    super.dispose();
  }
}
