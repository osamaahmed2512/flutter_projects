import 'package:flutter/material.dart';

class secondcustomtextfield extends StatefulWidget {
  const secondcustomtextfield( {super.key, required this.prefixicon, required this.hinttext, this.is_password =false, required this.controller });
  final Widget prefixicon;
  final bool is_password;
  final String hinttext;
  final TextEditingController controller;
  @override
  State<secondcustomtextfield> createState() => _secondcustomtextfieldState();
}

class _secondcustomtextfieldState extends State<secondcustomtextfield> {
   bool is_obsecure = true;
   
  @override
  Widget build(BuildContext context) {
    return TextFormField( 
          controller:widget.controller ,
          obscureText:widget.is_password ? is_obsecure : is_obsecure=false,
          decoration: InputDecoration(
             prefixIcon: widget.prefixicon,
             suffixIcon: widget.is_password?IconButton(icon:Icon(is_obsecure?  Icons.visibility:Icons.visibility_off),onPressed: () {
               setState(() {
                 is_obsecure = !is_obsecure;
               });
             },  ):null,
             hintText: widget.hinttext,
             enabledBorder: OutlineInputBorder(

              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Color(0xffD2D0E5),
                
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Color(0xffD2D0E5),

              )
            )
          ),
        );
  }
}