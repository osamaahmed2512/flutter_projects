import 'package:flutter/material.dart';

class SuccessScrean extends StatelessWidget {
  const SuccessScrean({super.key});

  static String id = 'SuccessScrean';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:  Text(
          'Deleted Successfully',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
    );
  }
}