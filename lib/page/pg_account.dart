import 'dart:io';

import 'package:base_flutter_firebase/data/object.dart';
import 'package:base_flutter_firebase/data/preference.dart';
import 'package:base_flutter_firebase/utilities/aniload.dart';
import 'package:base_flutter_firebase/utilities/dropdownsearch.dart';
import 'package:base_flutter_firebase/utilities/textfieldstyle.dart';
import 'package:base_flutter_firebase/utilities/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PageAccount extends StatefulWidget {
  @override
  _PageAccountState createState() => _PageAccountState();
}

class _PageAccountState extends State<PageAccount> {
  String? val_nama,val_email,val_username,val_password;
  String? val_userold;
  bool _obscureText=true;
  bool _edit=false;
  dynamic data_kategori;
  List <String> list_kategori=[];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> dataForm = {};
  DataForm(vars, val) {
    dataForm[vars] = val;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Warna.primary,
          leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,)),
          title: Text('Akun',style: TextStyle(color: Colors.white,),)),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
                .collection("auth")
                .doc(ThisUser.username)
                .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
           if(!snapshot.hasData){
             return AniLoad();
          }else {
             Map<String, dynamic> item = snapshot.data!.data() as Map<String, dynamic>;
             val_nama=item['Nama'];
             val_email=item['Email'];
             val_username=item['Username'];
             val_userold=item['Username'];
             val_password=item['Password'];
           return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: Ukuran(context, 10),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldStyle(
                      hintText: "Nama Lengkap",
                      valueText: val_nama,
                      enable: _edit,
                      onSaved: (val){
                        DataForm("Nama", val);
                      },
                      onChange: (val){
                        val_nama=val;
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Masukkan Nama Lengkap';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: Ukuran(context, 2),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldStyle(
                      hintText: "Email",
                      valueText: val_email,
                      enable: _edit,
                      onSaved: (val){
                        DataForm("Email", val);
                      },
                      onChange: (val){
                        val_email=val;
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Masukkan Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: Ukuran(context, 2),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldStyle(
                      hintText: "Username",
                      valueText: val_username,
                      enable: _edit,
                      onSaved: (val){
                        DataForm("Username", val);
                      },
                      onChange: (val){
                        val_username=val;
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Masukkan Username';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: Ukuran(context, 2),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldStyle(
                      hintText: "Password",
                      valueText: val_password,
                      enable: _edit,
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
                  ),
                  SizedBox(height: Ukuran(context, 10),),
                  _edit
                  ?Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: (){
                                //tulis fungsi klik disini
                                //  uploadgambar();
                                setState(() {
                                  _edit=!_edit;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Warna.text,
                                  onPrimary: Colors.white,
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                  padding: EdgeInsets.all(18)
                              ),
                              child: Text("Batal",style: TextStyle(fontWeight: FontWeight.bold ),)),
                        ),
                        SizedBox(width: Ukuran(context, 5),),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: (){
                                //tulis fungsi klik disini
                                updateUser();
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Warna.text,
                                  onPrimary: Colors.white,
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                  padding: EdgeInsets.all(18)
                              ),
                              child: Text("Simpan",style: TextStyle(fontWeight: FontWeight.bold ),)),
                        ),
                      ],
                    ),
                  )
                  :Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                        onPressed: (){
                          //tulis fungsi klik disini
                          //  uploadgambar();
                          setState(() {
                            _edit=!_edit;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Warna.primary,
                            onPrimary: Colors.white,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            minimumSize: Size(Ukuran(context,100), Ukuran(context, 15))
                        ),
                        child: Text("Ubah",style: TextStyle(fontWeight: FontWeight.bold ),)),
                  ),
                  SizedBox(height: Ukuran(context, 5),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                        onPressed: (){
                            Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                            setIsLogin(false);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Warna.primary,
                            onPrimary: Colors.white,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            minimumSize: Size(Ukuran(context,100), Ukuran(context, 15))
                        ),
                        child: Text("Log Out",style: TextStyle(fontWeight: FontWeight.bold ),)),
                  ),
                  SizedBox(height: Ukuran(context, 5),),
                ],
              ),

            ),
          );}
        }
      ),
    );
  }



  void updateUser() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      showProgressDialog(context);
      if(val_userold==val_username){
        DataForm('Id', ThisUser.username);
        print(dataForm.toString());
        FirebaseFirestore.instance.runTransaction((
            Transaction myTransaction) async {
          await myTransaction.update(FirebaseFirestore.instance.collection("auth").doc(ThisUser.username),dataForm);
        });
        Navigator.pop(context);
        toast("Akun Berhasil Diperbarui",color: Warna.green);
        setState(() {
          _edit=false;
        });
      } else{
        FirebaseFirestore.instance
            .collection('auth')
            .where("Username",isEqualTo: val_username)
            .get()
            .then((value) {
          if(value.docs.isNotEmpty){
            Navigator.pop(context);
            toast("Username sudah digunakan");
            }else {
            DataForm('Role', 'user');
            DataForm('Id', ThisUser.username);
            print(dataForm.toString());
            FirebaseFirestore.instance.runTransaction((
                Transaction myTransaction) async {
              await myTransaction.update(FirebaseFirestore.instance.collection("auth").doc(ThisUser.username),dataForm);
            });
            Navigator.pop(context);
            toast("Akun Berhasil Diperbarui");
            setState(() {
              _edit=false;
            });
          }
        });

      }
    }
  }
}
