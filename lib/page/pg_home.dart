import 'dart:ui';
import 'package:base_flutter_firebase/data/preference.dart';
import 'package:base_flutter_firebase/data/object.dart';
import 'package:base_flutter_firebase/utilities/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  String? user;
  void GetUsername()async{
    user = await getUser();
    setState((){
      ThisUser.username=user;
    });
  }

  @override
  initState() {
    super.initState();
    GetUsername();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Image(image: AssetImage(Gambar('bg_splash.png')),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: [
                  SizedBox(height: Ukuran(context, 40),),
                  Image(image: AssetImage(Gambar("logo.png")),width: 200,),
                  SizedBox(height: Ukuran(context, 30),),
                  ElevatedButton(
                      onPressed: (){
                        //tulis fungsi klik disini
                        Navigator.pushNamed(context, '/data');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Warna.primary,
                        onPrimary: Colors.white,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        minimumSize: Size(Ukuran(context,100), Ukuran(context, 15))
                      ),
                      child: Text("Produk",style: TextStyle(fontWeight: FontWeight.bold ),)),
                  SizedBox(height: Ukuran(context, 2),),
                  ElevatedButton(
                      onPressed: (){
                        //tulis fungsi klik disini
                        Navigator.pushNamed(context, '/account');
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Warna.primary,
                          onPrimary: Colors.white,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          minimumSize: Size(Ukuran(context,100), Ukuran(context, 15))
                      ),
                      child: Text("Akun",style: TextStyle(fontWeight: FontWeight.bold ),)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
