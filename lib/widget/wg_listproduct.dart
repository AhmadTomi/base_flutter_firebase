import 'package:base_flutter_firebase/utilities/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetListProduct extends StatelessWidget {
  final String nama,urlgambar;
  final dynamic data;
  final Function()? update,delete;
  const WidgetListProduct({required this.nama,required this.urlgambar,this.data,this.update,this.delete});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                )
              ]
          ),
          child: Column(
            children: [
              Image(image: NetworkImage(urlgambar)),
              SizedBox(height: Ukuran(context, 2),),
              Expanded(child: Text(nama,style: TextStyle(color: Warna.primary,fontSize: Ukuran(context, 4),fontWeight: FontWeight.bold
              ),textAlign: TextAlign.center,)),
              SizedBox(height: Ukuran(context, 2),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: update,
                    child: Icon(Icons.edit_rounded, color: Colors.white,size: Ukuran(context, 4),),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10),
                      primary: Warna.primary, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: delete,
                    child: Icon(Icons.delete_rounded, color: Colors.white,size: Ukuran(context, 4),),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      minimumSize: Size.zero,
                      padding: EdgeInsets.all(10),
                      primary: Warna.primary, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ],
    );
  }
}
