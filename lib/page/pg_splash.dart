import 'package:base_flutter_firebase/data/preference.dart';
import 'package:base_flutter_firebase/utilities/tools.dart';
import 'package:flutter/material.dart';

class PageSplash extends StatefulWidget {
  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  final controllerTopic = TextEditingController();
  bool isSubscribed = false;
  static String dataName = '';
  String token = '';
  static String dataAge = '';
  var appversion;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), () async {
      var login = await isLogin();
      // var Role = await getRole();
      debugPrint("islogin ${login}");
      if(login){
          Navigator.pushReplacementNamed(context, "/home");
      }else{
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Image(image: AssetImage(Gambar('bg_splash.png')),),
            Align(
                alignment: Alignment.center,
                child: Image(image: AssetImage(Gambar("logo.png")),width: 200,)
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Base Flutter Firebase v1.0",
                    style: TextStyle(color: Colors.black38, fontWeight: FontWeight.normal),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
