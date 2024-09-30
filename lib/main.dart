import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:volt/cubits/get_bottom%20navbar_cubit/bottom_navbar_cubits.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/pages/addmember.dart';
import 'package:volt/pages/addtrainer.dart';
import 'package:volt/pages/bottomnavigationbar.dart';
import 'package:volt/pages/loginpage.dart';
import 'package:volt/pages/signuppage.dart';
import 'package:volt/pages/splashscrean.dart';
import 'package:volt/pages/successscrean.dart';
import 'package:volt/pages/viewtrainer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBarCubit(),
      child: MaterialApp(
        routes: {
          AddMemberPage.id: (context) => AddMemberPage(),
          BottomNavBar.id: (context) => BottomNavBar(),
          loginpage.id: (context) => loginpage(),
          SignUpPage.id: (context) => SignUpPage(),
          SplashScreen.id: (context) => SplashScreen(),
          SuccessScrean.id: (context) => SuccessScrean(),
          VeiwTrainer.id:(context) => VeiwTrainer(),
          AddTrainerPage.id:(context) => AddTrainerPage(),
        },
        title: '',
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
      ),
    );
  }
}

