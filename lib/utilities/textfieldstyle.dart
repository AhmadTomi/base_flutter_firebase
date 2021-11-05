import 'dart:ui';
import 'package:base_flutter_firebase/utilities/tools.dart';
import 'package:flutter/material.dart';
class TextFieldStyle extends StatelessWidget {
  final String? hintText,valueText;
  final void Function(String?)? onSaved;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final controller;
  final preficon;
  final sufficon;
  final TextInputType? keytype;

  bool obscuretext,enable  ;

  TextFieldStyle({Key? key, this.hintText, this.valueText , this.onSaved, this.validator,this.controller,this.obscuretext= false,this.enable= true,this.preficon,this.sufficon,this.keytype,this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscuretext,
      controller: controller,
      initialValue: valueText,
      onSaved: onSaved,
      onChanged:onChange,
      validator:validator,
      enabled: enable,
      keyboardType: keytype,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black38),
        filled: true,
        contentPadding: EdgeInsets.all(15.0),
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Warna.text.withOpacity(0.2),width: 0.5)),
        prefixIcon: preficon,
        suffixIcon: sufficon,
      ),

    );
  }
}
