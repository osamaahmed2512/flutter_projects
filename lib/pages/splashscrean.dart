

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:volt/pages/bottomnavigationbar.dart';
import 'package:volt/pages/loginpage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const id ="SplashScreen";
  @override
  Widget build(BuildContext context) { 
    // checkloginstatus(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<User?>(
        stream:FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child:CircularProgressIndicator(),);
          }
          else if(snapshot.connectionState==ConnectionState.active){
            User? user = snapshot.data;
                
              if (user != null) {
                Future.microtask(() =>  Navigator.pushReplacementNamed(context, BottomNavBar.id,));
                
              } else {
                Future.microtask(() => Navigator.pushReplacementNamed(context, loginpage.id));
                  }

          }
            return SizedBox();
        },
        ),
    );
  }
  }
  // void checkloginstatus(BuildContext context) async{
  //  await Future.delayed(const Duration(seconds: 1));
  //  User? user = FirebaseAuth.instance.currentUser;
  //  if (user != null) {
  //     Navigator.pushReplacementNamed(context, BottomNavBar.id);
  //   } else {
  //     Navigator.pushReplacementNamed(context, loginpage.id);
  //   }
  // }
