
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:volt/config/palette.dart';
import 'package:volt/helper/show_snack_bar.dart';
import 'package:volt/helper/snackbar_floating.dart';
import 'package:volt/models/memberdetails.dart';

class CardItems extends StatelessWidget {
  const CardItems({
    required this.memberDetails,
    super.key,
  });
  final MemberDetails memberDetails;
  
  Future<void> deleteMember(BuildContext context) async{
    try {
  await FirebaseFirestore.instance.collection('trainers').doc(memberDetails.id).delete();
  SnackBar_Floating(context, text: "Memeber Deleted Succesfully !", color: Colors.green);
}  catch (e) {
  if (context.mounted) {
  Showsnackbar(context, 'Failed to delete trainer: $e');
}
}
  }
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffD6D6D6), borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      "assets/images/google_PNG19635.png",
                      height: 50,
                      width: 50,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      Text(
                        memberDetails.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      Text(
                        memberDetails.phonenumber,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                      Text(
                        memberDetails.paydate,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: palette.fourthcolor,
                            fontSize: 16),
                      ),
                      Text(
                        memberDetails.fee,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: palette.fourthcolor,
                            fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Spacer(flex: 1),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async{
                        final Uri url = Uri(scheme:"tel",path: memberDetails.phonenumber);  
                        while(! await launchUrl(url)){
                          Showsnackbar(context,'cannot launch this url');
                          break;
                        }
                        
                        },
                        child: Icon(
                          Icons.call,
                          size: 40,
                        ),
                      ),
                      Text(
                        "call",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )
                    ],
                  ),
                  Spacer(flex: 1),
                  Column(
                    children: [
                      Icon(
                        Icons.message,
                        size: 40,
                      ),
                      Text(
                        "message",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )
                    ],
                  ),
                  Spacer(flex: 1),
                  Column(
                    children: [
                      ImageIcon(AssetImage("assets/images/3103578.png"),
                          size: 30, color: Colors.black),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "renew",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )
                    ],
                  ),
                  Spacer(flex: 1),
                  GestureDetector(
                    onTap: () {
                      AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.rightSlide,
                      title: 'Hello ${memberDetails.name.split(" ")[0]}',
                      desc: 'Are you sure you want to delete',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {deleteMember(context);},
                      )..show();
                      
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.delete,
                          size: 40,
                        ),
                        Text(
                          "delete",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
