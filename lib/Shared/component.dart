import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller , // input
  required TextInputType type , // keyboard type
  String hintText = 'Enter an answer',
  String? label ,
  IconData? prefix , // for making icon
  IconData? suffix ,
  Function? validate ,
  Function? onSubmit , // accepts null
  Function? onChange,
  Function? onTap , // optional = null

}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onTap: (){
    onTap!();
  },
  onFieldSubmitted: (value){ // when done putting data
    onSubmit!(value); // calling
  },
  onChanged: (value){
    onChange!(value);
  },
  validator: (value){
    if(value == null || value.isEmpty){
      return validate!(value);
    }
  },
  decoration: InputDecoration(
    hintText: hintText,
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: Icon(suffix),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);