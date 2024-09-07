import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volt/config/palette.dart';
import 'package:volt/models/memberdetails.dart';
import 'package:volt/pages/addtrainer.dart';
import 'package:volt/widgets/carditem.dart';

class VeiwTrainer extends StatefulWidget {
  VeiwTrainer({super.key});
  static String id = "VeiwTrainer";

  @override
  State<VeiwTrainer> createState() => _VeiwTrainerState();
}

class _VeiwTrainerState extends State<VeiwTrainer> {
  final TextEditingController _searchcontroller = TextEditingController();

  final Stream<QuerySnapshot> _TrainerStream =
      FirebaseFirestore.instance.collection('trainers').snapshots();

  List<MemberDetails> Trainerdetailslist = [];

  List<MemberDetails> FilterTrainerdetailslist = [];

  void _filtermembers() {
    String Query = _searchcontroller.text.toLowerCase();
    setState(() {
      if (Query.isEmpty) {
        FilterTrainerdetailslist = Trainerdetailslist;
      } else {
        FilterTrainerdetailslist = Trainerdetailslist.where(
            (trainer) => trainer.name.toLowerCase().contains(Query)).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          height: 55,
          decoration: BoxDecoration(color: Colors.white),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(15),
            child: TextField(
              onChanged: (value) => _filtermembers(),
              controller: _searchcontroller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 39),
                hintStyle: TextStyle(color: Colors.black, fontSize: 17),
                hintText: "Search for a Member",
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color(0xffD2D0E5),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color(0xffD2D0E5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Trainer",
                  style: TextStyle(
                      color: Color(0xff030870),
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _TrainerStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text("Loading"));
                  }

                  // for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  //   Trainerdetailslist.add(MemberDetails.fromjson(snapshot.data!.docs[i]));
                  // }
                  Trainerdetailslist.clear();
                  Trainerdetailslist = snapshot.data!.docs
                      .map((tainer) => MemberDetails.fromjson(tainer))
                      .toList();
                  if (FilterTrainerdetailslist.isEmpty &&
                      _searchcontroller.text.isEmpty) {
                    FilterTrainerdetailslist = List.from(Trainerdetailslist);
                  }

                  return ListView.builder(
                    itemCount: FilterTrainerdetailslist.length,
                    itemBuilder: (context, index) {
                      return CardItems(
                        memberDetails: FilterTrainerdetailslist[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: palette.thirdcolor.withOpacity(0.7),
        onPressed: () {
          Navigator.pushNamed(context, AddTrainerPage.id);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
