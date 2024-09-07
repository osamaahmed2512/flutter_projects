import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.w600),
          
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
             enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              )
            )
          ),
        ),
       SizedBox(height: 30,),
      ],
    );
  }
}
