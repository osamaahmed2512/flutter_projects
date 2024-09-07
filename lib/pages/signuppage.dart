import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:volt/cubits/get_bottom%20navbar_cubit/bottom_navbar_cubits.dart';
import 'package:volt/helper/show_snack_bar.dart';
import 'package:volt/pages/bottomnavigationbar.dart';
import 'package:volt/widgets/custombutton.dart';
import 'package:volt/widgets/customtextfield2.dart';
import 'package:volt/widgets/customtitle.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});
  static const id = 'SignUpPage';
   User? user = FirebaseAuth.instance.currentUser;
   final TextEditingController nameController = TextEditingController();
   final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

     Future<void> _register(BuildContext context) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      user = userCredential.user;
      if (user !=null){
        await user!.updateDisplayName(nameController.text);
        await user!.reload();  // Reload the user to update profile
        FirebaseAuth.instance.currentUser;
      }
      BlocProvider.of<BottomNavBarCubit>(context).selectTab(0);
      Navigator.pushReplacementNamed(context,BottomNavBar.id);
      Showsnackbar(context, ('Success'));
      // Navigate to your home screen or dashboard
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Showsnackbar(context, 'The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
     Showsnackbar(context, 'The account already exists for that email.');
   
  }
  else{
    Showsnackbar(context, e.toString());
  }
    }
    catch (e) {
      Showsnackbar(context, e.toString());
     
      }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTiltle(text1: 'Volt', text2: 'Gym'),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "create an account ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                   secondcustomtextfield(
                    
                      prefixicon:const Padding(
                        padding: EdgeInsets.only(left: 13,top: 10 ),
                        child: FaIcon(FontAwesomeIcons.user,size:30,),
                      ),
                      hinttext: "Enter Your Name",
                      controller: nameController),

                  const SizedBox(
                    height: 30,
                  ),
                   secondcustomtextfield(
                      prefixicon: Icon(Icons.email_outlined, size: 30),
                      hinttext: "Enter Email",
                      controller: emailController),
                  const SizedBox(
                    height: 30,
                  ),
                   secondcustomtextfield(
                    prefixicon: Icon(Icons.lock_outline, size: 30),
                    hinttext: "Enter Password",
                    is_password: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "forget password",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff030870),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                   CustomButton(label:"SignUp" ,onperssed: () =>_register(context) ,),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("SignUp With"),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.facebook,
                            color: Color(0xff3B5599),
                            size: 40,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.asset("assets/images/google_PNG19635.png",
                            height: 50, width: 50),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.apple,
                              color: Color(0xff3B5599),
                              size: 45,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an Account?",
                        style: TextStyle(fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color(0xff030870),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
