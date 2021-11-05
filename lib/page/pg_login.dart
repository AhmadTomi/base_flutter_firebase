import 'dart:ui';

import 'package:base_flutter_firebase/data/preference.dart';
import 'package:base_flutter_firebase/utilities/textfieldstyle.dart';
import 'package:base_flutter_firebase/utilities/tools.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class PageLogin extends StatefulWidget {
  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  bool _obscureText=true;
  String? val_username,val_password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: Ukuran(context, 20),),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image(image: AssetImage(Gambar("logo.png")),),
              ),
              SizedBox(height: Ukuran(context, 20),),
              TextFieldStyle(
                hintText: "Username",
                valueText: val_username,
                onSaved: (val){
                  val_username = val;
                },
                onChange: (val){
                  val_username = val;
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Masukkan Username';
                  }
                  return null;
                },
              ),
              SizedBox(height: Ukuran(context, 2),),
              TextFieldStyle(
                hintText: "Password",
                valueText: val_password,
                obscuretext: _obscureText,
                sufficon:new GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child:
                  new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                ),
                onSaved: (val){
                  val_password = val;
                },
                onChange: (val){
                  val_password = val;
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Masukkan Password';
                  }
                  return null;
                },
              ),
              SizedBox(height: Ukuran(context, 10),),
              ElevatedButton(
                  onPressed: (){
                    //tulis fungsi klik disini
                  login();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Warna.primary,
                    onPrimary: Colors.white,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    minimumSize: Size(Ukuran(context,100), Ukuran(context, 15))
                  ),
                  child: Text("Masuk",style: TextStyle(fontWeight: FontWeight.bold ),)),
              SizedBox(height: Ukuran(context, 5),),
              Center(
                child: RichText(
                  text: TextSpan(text: "Belum punya akun ?", style: TextStyle(color: Warna.primary, fontSize: Ukuran(context, 3.8)), children: <TextSpan>[
                    TextSpan(
                        text: ' Daftar',
                        style: TextStyle(color: Colors.blueAccent, fontSize: Ukuran(context, 3.8),fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(context, '/register');
                          })
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    _formKey.currentState!.save();
    print(val_username);
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance
          .collection('auth')
          .where('Username', isEqualTo: val_username)
          .limit(1)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          print(value.docs[0].id);
          if (value.docs[0].data()['Password'] == val_password) {
              Navigator.pushReplacementNamed(context, '/home');

            setIsLogin(true);
            setUser(value.docs[0].id);
            setRole(value.docs[0].data()['Role']);
            toast("Berhasil Masuk",color: Warna.green);
          } else {
            toast("Password Salah",color: Warna.red);
          }
        } else {
          toast("Username tidak ditemukan");
        }
      });
    }
  }
}
