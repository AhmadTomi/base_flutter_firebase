import 'dart:io';

import 'package:base_flutter_firebase/data/object.dart';
import 'package:base_flutter_firebase/utilities/aniload.dart';
import 'package:base_flutter_firebase/utilities/dropdownsearch.dart';
import 'package:base_flutter_firebase/utilities/textfieldstyle.dart';
import 'package:base_flutter_firebase/utilities/tools.dart';
// import 'package:base_flutter_firebase/widget/wg_listcategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PageDataUpdate extends StatefulWidget {
  const PageDataUpdate({Key? key}) : super(key: key);
  @override
  _PageDataUpdateState createState() => _PageDataUpdateState();
}

class _PageDataUpdateState extends State<PageDataUpdate> {
  XFile? _image;
  String? urlupload,val_nama,val_kategori,val_detail;
  String? val_user,urlgambar;
  bool isSwitched =SelectedData.data["Active"];
  dynamic data_kategori;
  List <String> list_kategori=[];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> dataForm = {};
  DataForm(vars, val) {
    dataForm[vars] = val;
  }

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    val_user=ThisUser.username;
    val_nama = SelectedData.data["Nama"];
    val_detail = SelectedData.data["Detail"];
    urlgambar = SelectedData.data["Gambar"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.primary,
          leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,)),
          title: Text('Tambah Data',style: TextStyle(color: Colors.white,),)),
      body: SingleChildScrollView(

        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: Ukuran(context, 100),
                height: Ukuran(context, 100),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(image:
                                    (_image==null)
                                        ?NetworkImage(urlgambar!) as ImageProvider
                                        :FileImage(File(_image!.path)),
                                    fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Warna.primary,width: 4),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            onPressed: (){
                              //tulis fungsi klik disini
                              getImage();
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Warna.primary.withOpacity(0.2),
                                onPrimary: Colors.white,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                minimumSize: Size(Ukuran(context,50), Ukuran(context, 15),),
                                side: BorderSide(color: Warna.primary,width: 2),
                            ),
                            child: Text("UPLOAD",style: TextStyle(fontWeight: FontWeight.bold ),)),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFieldStyle(
                  hintText: "Nama Data",
                  valueText: val_nama,
                  onSaved: (val){
                    DataForm("Nama", val);
                  },
                  onChange: (val){
                    val_nama=val;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Masukkan Nama Data';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: Ukuran(context, 2),),
              SizedBox(height: Ukuran(context, 2),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFieldStyle(
                  hintText: "Detail",
                  valueText: val_detail,
                  onSaved: (val){
                    DataForm("Detail", val);
                  },
                  onChange: (val){
                    val_detail=val;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Masukkan Detail';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: Ukuran(context, 2),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Switch(
                      value: isSwitched,
                      onChanged: (value){
                        setState(() {
                          isSwitched=value;
                        });
                      },
                      activeTrackColor: Warna.secondary,
                      activeColor: Warna.primary,
                    ),
                    Text("Publish data?",style: TextStyle(color: Warna.text),)
                  ],
                ),
              ),
              SizedBox(height: Ukuran(context, 5),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                    onPressed: (){
                      //tulis fungsi klik disini
                      (_image!=null)? updategambar():updatetanpagambar();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Warna.primary,
                        onPrimary: Colors.white,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        minimumSize: Size(Ukuran(context,100), Ukuran(context, 15))
                    ),
                    child: Text("Simpan",style: TextStyle(fontWeight: FontWeight.bold ),)),
              ),

              SizedBox(height: Ukuran(context, 5),),
            ],
          ),

        ),
      ),
    );
  }


  void updategambar ()async{
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      DataForm("Active",isSwitched);
      showProgressDialog(context);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("image" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(File(_image!.path));
      uploadTask.whenComplete(() async {
        urlupload = await ref.getDownloadURL();
        DataForm("Gambar", urlupload);
        DataForm("User", val_user);
        await FirebaseFirestore.instance.runTransaction((
            Transaction myTransaction) async {
          await myTransaction.update(SelectedData.dataref, dataForm);
        });
      toast("Berhasil Diperbarui",color: Warna.green);
        Navigator.pop(context);
        Navigator.pop(context);
      }).catchError((onError) {
        print(onError);
        Navigator.pop(context);
        toast("Gagal Upload Coba Lagi",color: Warna.red);
      });

    }

  }
  void updatetanpagambar() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      DataForm("Active",isSwitched);
      DataForm("Gambar", urlgambar);
      DataForm("User", val_user);
      showProgressDialog(context);
      await FirebaseFirestore.instance.runTransaction((
          Transaction myTransaction) async {
        await myTransaction.update(SelectedData.dataref, dataForm);
      });
      toast("Berhasil Diperbarui",color: Warna.green);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
