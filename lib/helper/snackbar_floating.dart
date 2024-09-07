import 'package:flutter/material.dart';

void SnackBar_Floating(BuildContext context, {required String text, required Color color}){

   ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(text),
              backgroundColor: color,
              behavior: SnackBarBehavior.floating,
            ),
          );
}


