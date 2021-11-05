// import 'package:base_flutter_firebase/utilities/tools.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
//
//
// class DropdownStyle extends StatefulWidget {
//   String? valueText,title;
//   final Function? onSaved;
//   final Function? onChange;
//   final Function? validator;
//   final List <String>? mylist;
//   Widget Function(BuildContext context,String string,bool Bool)? popupWidget;
//   bool Enabled;
//   bool cari;
//   Color warna,warnaborder;
//
//
//   DropdownStyle({Key ?key,this.mylist, this.valueText ,this.title, this.onSaved, this.validator,this.Enabled=true,this.onChange,this.popupWidget,this.cari=true,this.warna=Colors.white , this.warnaborder = Colors.black54});
//
//   @override
//   _DropdownStyleState createState() => _DropdownStyleState();
// }
//
//
//
// class _DropdownStyleState extends State<DropdownStyle> {
//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: SizedBox(
//         height: Ukuran(context, 13.5),
//         child: DropdownSearch<String>(
//           dropdownSearchDecoration: InputDecoration(
//             filled: true,
//             fillColor: widget.Enabled ? widget.warna : Color(0xFFEDEDED),
//             enabled: widget.Enabled,
//             hintText: widget.title,
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: BorderSide(color: widget.warnaborder, width: 1)),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(7.0),
//                 borderSide: BorderSide(color: Warna.text.withOpacity(0.2),width: 0.5)),
//             contentPadding: EdgeInsets.symmetric(
//                 horizontal: 10, vertical: 2),
//           ),
//           showSearchBox: widget.cari,
//           searchBoxDecoration: InputDecoration(
//             suffixIcon: Icon(Icons.search_rounded),
//             filled: true,
//             fillColor: Color(0xFFF0F0F0),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: BorderSide(
//                     color: Warna(2).withOpacity(0.2), width: 0.5)),
//             contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//           ),
//           mode: Mode.DIALOG,
//           showSelectedItem: true,
//           items: widget.mylist,
//           enabled: widget.Enabled,
//           onChanged: widget.onChange,
//           // onChanged: (value) => widget.valueText = value,
//           onSaved: widget.onSaved,
//           validator: widget.validator,
//           selectedItem: widget.valueText,
//           emptyBuilder: kosong,
//           popupTitle: Container(
//             height: 50,
//             decoration: BoxDecoration(
//               color: Warna(0),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 widget.title,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           popupShape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10)),
//
//         ),
//       ),
//     );
//   }
//
//   Widget kosong(BuildContext context, String kosong) {
//     return Center(child: SizedBox(width: Ukuran(context, 30),
//         child: Image.asset("assets/images/alert_cari_null.png")));
//   }
//
// }