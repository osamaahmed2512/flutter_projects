
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.label, required this.onperssed,
  });
  final String label; 
  final VoidCallback onperssed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 350,
      child: ElevatedButton(
        onPressed: onperssed,
        child: Ink(
         decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
               Color(0xff030870),
                Color(0xffE10000)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.50,1.0],
            ),
            
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
