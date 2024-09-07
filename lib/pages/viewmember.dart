import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volt/config/palette.dart';
import 'package:volt/models/memberdetails.dart';
import 'package:volt/pages/addmember.dart';
import 'package:volt/widgets/carditem.dart';

class VeiwMember extends StatefulWidget {
  VeiwMember({super.key});

  @override
  State<VeiwMember> createState() => _VeiwMemberState();
}

class _VeiwMemberState extends State<VeiwMember> {
  final TextEditingController _searchcontroller = TextEditingController();

  final Stream<QuerySnapshot> _memberStream =
      FirebaseFirestore.instance.collection('members').snapshots();
  List<MemberDetails> memberdetailslist = [];
  List<MemberDetails> filtermemberdetailslist = [];

  void _filtermembers() {
    String Query = _searchcontroller.text.toLowerCase();
    setState(() {
      if (Query.isEmpty) {
        filtermemberdetailslist = memberdetailslist;
      } else {
        filtermemberdetailslist = memberdetailslist
            .where((member) => member.name.toLowerCase().contains(Query))
            .toList();
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
                  "Members",
                  style: TextStyle(
                      color: Color(0xff030870),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _memberStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  memberdetailslist.clear();
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    memberdetailslist
                        .add(MemberDetails.fromjson(snapshot.data!.docs[i]));
                  }

                  if (filtermemberdetailslist.isEmpty &&
                      _searchcontroller.text.isEmpty) {
                    filtermemberdetailslist = List.from(memberdetailslist);
                  }
                  return ListView.builder(
                    itemCount: filtermemberdetailslist.length,
                    itemBuilder: (context, index) {
                      return CardItems(
                        memberDetails: filtermemberdetailslist[index],
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
          Navigator.pushNamed(context, AddMemberPage.id);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
