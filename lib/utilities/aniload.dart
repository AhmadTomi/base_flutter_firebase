import 'package:base_flutter_firebase/utilities/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class AniLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(color: Warna.primary,size: Ukuran(context, 7),);
  }
}
