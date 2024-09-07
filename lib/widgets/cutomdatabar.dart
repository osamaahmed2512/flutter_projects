import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:volt/config/palette.dart';

class Custtomdatabar extends StatelessWidget {
  const Custtomdatabar({
    super.key,
    required this.text, required this.faicon,
  });
  final String text;
  final FaIcon faicon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: palette.secondarycolor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
     
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric( vertical:10 ),
        child: Row(
          children: [
             Padding(
                    padding: EdgeInsets.only(left: 13,top: 10 ),
                    child:faicon,
                  ),
            Text(text,style: TextStyle(color: Colors.white)),      
          ],
        ),
      ),
    );
  }
}


class Custtomdatabartwo extends StatelessWidget {
  const Custtomdatabartwo({
    super.key,
    required this.text, required this.faicon, required this.ontap,
  });
  final String text;
  final FaIcon faicon;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: palette.secondarycolor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
       
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
               Padding(
                      padding: EdgeInsets.only(left: 13,top: 3 ),
                      child:faicon,
                    ),
                    SizedBox(width: 8,),
              Text(text,style: TextStyle(color: Colors.white)),      
            ],
          ),
        ),
      ),
    );
  }
}



