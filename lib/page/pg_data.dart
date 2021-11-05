import 'package:base_flutter_firebase/data/object.dart';
import 'package:base_flutter_firebase/data/preference.dart';
// import 'package:base_flutter_firebase/dialog/dialog_kategori.dart';
import 'package:base_flutter_firebase/utilities/emptydata.dart';
import 'package:base_flutter_firebase/utilities/tools.dart';
import 'package:base_flutter_firebase/utilities/aniload.dart';
import 'package:base_flutter_firebase/widget/wg_listproduct.dart';
// import 'package:base_flutter_firebase/widget/wg_listcategory.dart';
// import 'package:base_flutter_firebase/widget/wg_listproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class PageData extends StatefulWidget {
  @override
  _PageDataState createState() => _PageDataState();
}

class _PageDataState extends State<PageData> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ElevatedButton(
          onPressed: (){
            //tulis fungsi klik disini
            Navigator.pushNamed(context, '/data_add');
          },
          style: ElevatedButton.styleFrom(
              primary: Warna.primary,
              onPrimary: Colors.white,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
              minimumSize: Size(Ukuran(context,100), Ukuran(context, 15))
          ),
          child: Text("Tambah",style: TextStyle(fontWeight: FontWeight.bold ),)),
      appBar: AppBar(
        backgroundColor: Warna.primary,
          leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,)),
          title: Text('Data',style: TextStyle(color: Colors.white,),)),
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                    .collection("data")
                    // .where('User', isEqualTo: ThisUser.username)
                    .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData){
                return AniLoad();} else{
                if(snapshot.data!.docs.isEmpty){
                  return Padding(
                    padding: const EdgeInsets.all(30),
                    child: EmptyData(),
                  );
                }else{
                  return GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3/4.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext ctx, index) {
                      DocumentSnapshot item = snapshot.data!.docs[index];
                      return WidgetListProduct(
                        data: item.reference,
                        nama: item['Nama'],
                        urlgambar: item['Gambar'],
                        update:(){
                          Update(item.data(),item.reference,);
                        },
                        delete: (){
                          hapus(item.reference);
                        },
                      );
                    },

                  );
                }

              }
            }
          )
        ],
      ),
    );
  }

  void Update(data,dataref){
  SelectedData.data=data;
  SelectedData.dataref=dataref;
  Navigator.pushNamed(context, '/data_update');
  }

  void hapus(dataref) async{
    showProgressDialog(context);
    await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
      await myTransaction.delete(dataref);
    });
    Navigator.pop(context);
  }
}

