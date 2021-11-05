import 'dart:ui';
import 'package:base_flutter_firebase/data/preference.dart';
import 'package:base_flutter_firebase/utilities/textfieldstyle.dart';
import 'package:base_flutter_firebase/utilities/tools.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class PageRegister extends StatefulWidget {
  @override
  _PageRegisterState createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  bool _obscureText=true;
  String? val_namalengkap,val_email,val_username,val_password;
  List <String> list_username=[];
  Map<String, dynamic> dataForm = {};
  DataForm(vars, val) {
    dataForm[vars] = val;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()async{
          Navigator.pushReplacementNamed(context, '/login');
      return false;

      },
      child: Scaffold(
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
                SizedBox(height: Ukuran(context, 10),),
                TextFieldStyle(
                  hintText: "Nama Lengkap",
                  valueText: val_namalengkap,
                  onSaved: (val){
                    DataForm("Nama", val);
                  },
                  onChange: (val){
                    val_namalengkap = val;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Masukkan NamaLengkap';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Ukuran(context, 2),),
                TextFieldStyle(
                  hintText: "Email",
                  valueText: val_email,
                  onSaved: (val){
                    DataForm("Email", val);
                  },
                  onChange: (val){
                    val_email = val;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Masukkan Email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Ukuran(context, 2),),
                TextFieldStyle(
                  hintText: "Username",
                  valueText: val_username,
                  onSaved: (val){
                    DataForm("Username", val);
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
                    DataForm("Password", val);
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
                      registerUser();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Warna.primary,
                      onPrimary: Colors.white,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      minimumSize: Size(Ukuran(context,100), Ukuran(context, 15))
                    ),
                    child: Text("Daftar",style: TextStyle(fontWeight: FontWeight.bold ),)),
                SizedBox(height: Ukuran(context, 5),),
                Center(
                  child: RichText(
                    text: TextSpan(text: "Sudah punya akun ?", style: TextStyle(color: Warna.text, fontSize: Ukuran(context, 3.8)), children: <TextSpan>[
                      TextSpan(
                          text: ' Login',
                          style: TextStyle(color: Colors.blueAccent, fontSize: Ukuran(context, 3.8),fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(context, '/login');
                            })
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerUser() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      String newid;
      showProgressDialog(context);
      FirebaseFirestore.instance
          .collection('auth')
          .get()
          .then((value) {
            print(value.docs.isEmpty);
        if(value.docs.isEmpty) {
          newid="0";
        }
        else {
          newid = (int.parse(value.docs[value.docs.length - 1].data()['Id']) + 1).toString();
          list_username.clear();
          value.docs.forEach((element) {
            list_username.add(element.data()['Username']);
          });
        }
        if(list_username.contains(val_username)){
          Navigator.pop(context);
          toast("Username sudah digunakan",);
        }else {
          DataForm("Id",newid);
          DataForm('Role', 'user');
          print(dataForm.toString());
          FirebaseFirestore.instance.runTransaction((
              Transaction myTransaction) async {
            await myTransaction.set(FirebaseFirestore.instance.collection("auth").doc(newid),dataForm);
            setIsLogin(true);
            setUser(newid);
            setRole('user');
          });
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, "/home");
          toast("Registrasi Berhasil",color: Warna.green);
        }


      });
    }
  }


}
