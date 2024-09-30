import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:volt/config/palette.dart';
import 'package:volt/helper/show_snack_bar.dart';
import 'package:volt/helper/snackbar_floating.dart';
import 'package:volt/models/memberdetails.dart';

class CardItems extends StatefulWidget {
  const CardItems({
    required this.memberDetails,

    super.key, required this.collection,
  });
  final MemberDetails memberDetails;
  final String collection; 
  @override
  State<CardItems> createState() => _CardItemsState();
}

class _CardItemsState extends State<CardItems> {
  Future<void> deleteMember(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection(widget.collection)
          .doc(widget.memberDetails.id)
          .delete();
      setState(() {
        snackBarFloating(context,
            text: "Memeber Deleted Succesfully !", color: Colors.green);
      });
    } catch (e) {
     snackBarFloating(context,
            text: "Memeber failed to delete !", color: Colors.red);
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
                    child:CircleAvatar(
                      radius: 40,
                      backgroundImage: widget.memberDetails.image != null && widget.memberDetails.image!.isNotEmpty
                          ? NetworkImage(widget.memberDetails.image!)
                          : AssetImage("assets/images/google_PNG19635.png") as ImageProvider,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      Text(
                        widget.memberDetails.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      Text(
                        widget.memberDetails.phonenumber,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                      Text(
                        widget.memberDetails.paydate,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: palette.fourthcolor,
                            fontSize: 16),
                      ),
                      Text(
                        widget.memberDetails.fee,
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
                        onTap: () async {
                          final Uri url = Uri(
                              scheme: "tel",
                              path: widget.memberDetails.phonenumber);
                          while (!await launchUrl(url)) {
                            Showsnackbar(context, 'cannot launch this url');
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
                        title:
                            'Hello ${widget.memberDetails.name.split(" ")[0]}',
                        desc: 'Are you sure you want to delete',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          deleteMember(context);
                        },
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
