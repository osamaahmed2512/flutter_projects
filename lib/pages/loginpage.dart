import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/cubits/get_bottom%20navbar_cubit/bottom_navbar_cubits.dart';
import 'package:volt/helper/show_snack_bar.dart';
import 'package:volt/pages/bottomnavigationbar.dart';
import 'package:volt/pages/signuppage.dart';
import 'package:volt/widgets/custombutton.dart';
import 'package:volt/widgets/customtextfield2.dart';
import 'package:volt/widgets/customtitle.dart';

class loginpage extends StatelessWidget {
   loginpage({super.key});
  static const id = "loginpage";
   final  emailController = TextEditingController();
    final  passwordController = TextEditingController();

    
  Future<void> _login(BuildContext context) async {
      String email = emailController.text.trim();
  String password = passwordController.text;
      if (!EmailValidator.validate(email)) {
    Showsnackbar(context, 'Please enter a valid email address.');
    return; // Exit the function if the email is invalid
  }
    try {

      
      // Attempt to sign in the user
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      BlocProvider.of<BottomNavBarCubit>(context).selectTab(0);

      Navigator.pushReplacementNamed(context,BottomNavBar.id);
      Showsnackbar(context, 'success');
      // Navigate to your home screen or dashboard
    } on FirebaseAuthException catch (e) {
      if (e.code =='invalid-credential') {
         Showsnackbar(context, 'invald credential try again');
      } else if (e.code == 'wrong-password') {
         Showsnackbar(context, 'Wrong password provided.');
        
      }
      else {
        Showsnackbar(context, e.toString());
      }
    } catch (e) {
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
                    height: 70,
                  ),
               CustomTiltle(text1: 'Active', text2: 'Gym'),
                  const SizedBox(
                    height: 70,
                  ),
                  const Text(
                    "please login with your personal information ",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                   secondcustomtextfield(
                      prefixicon: Icon(Icons.email_outlined, size: 30),
                      hinttext: "Enter Email",controller:emailController ),
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
                   CustomButton(label: "LogIn",onperssed:() => _login(context),),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Login With"),
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
                        width: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.asset(
                            "assets/images/google_PNG19635.png",
                            height: 50,
                            width: 50),
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
                        "Don't have an Account?",
                        style: TextStyle(fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context,SignUpPage.id);
                        },
                        child: const Text(
                          "Sign Up",
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
