
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:volt/pages/loginpage.dart';
import 'package:volt/widgets/customappbar.dart';
import 'package:volt/widgets/cutomdatabar.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});
  final User? user = FirebaseAuth.instance.currentUser;
  Future<void> _signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacementNamed(context, loginpage.id);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(name: "Settings"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("ACCOUNT"),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  print(user?.displayName);
                },
                child: Custtomdatabar(
                    text: "signed in as ${ user?.displayName ??'un known'}",
                    faicon: FaIcon(FontAwesomeIcons.user,
                        size: 30, color: Colors.white)),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Custtomdatabartwo(
                ontap: () => _signOut(context),
                text: "SignOut",
                faicon: FaIcon(
                  FontAwesomeIcons.signOut,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
