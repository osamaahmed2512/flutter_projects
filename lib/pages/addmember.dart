import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:volt/helper/snackbar_floating.dart';
import 'package:volt/widgets/custombutton.dart';
import 'package:volt/widgets/customtextfield2.dart';
import 'package:volt/widgets/customtitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddMemberPage extends StatefulWidget {
  AddMemberPage({super.key});
  static String id = "AddMemberPage";

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  final TextEditingController _firstnamecontroller = TextEditingController();

  final TextEditingController _secondnamecontroller = TextEditingController();

  final TextEditingController _Adresscontroller = TextEditingController();

  final TextEditingController _phoneNumbercontroller = TextEditingController();

  final TextEditingController _registrerationcontroller =
      TextEditingController();
  final TextEditingController _birthdatecontroller = TextEditingController();
  final TextEditingController _feecontroller = TextEditingController();

  final CollectionReference trainers =
      FirebaseFirestore.instance.collection('members');

  void initState() {
    super.initState();
    // Set the registration date to today's date in 'yyyy-MM-dd' format
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _registrerationcontroller.text = formattedDate;
    // _birthdatecontroller.text = formattedDate;
  }

  void clearFieldsAndUnfocus() {
    // Clear text fields
    _firstnamecontroller.clear();
    _secondnamecontroller.clear();
    _Adresscontroller.clear();
    _phoneNumbercontroller.clear();
    _feecontroller.clear();
    _birthdatecontroller.clear();
    // Close the keyboard
    FocusScope.of(context).unfocus();
  }

  Future<void> addTrainer() async {
    // Call the user's CollectionReference to add a new user
    try {
      await trainers.add({
        'first_name': _firstnamecontroller.text, // John Doe
        'last_name': _secondnamecontroller.text, // John Doe
        'address': _Adresscontroller.text, // Stokes and Sons
        'phonenumber': _phoneNumbercontroller.text,
        'registerationdate': _registrerationcontroller.text,
        'fee': _feecontroller.text,
        'birthdatecontroller': _birthdatecontroller.text,
        // 42
      });
      clearFieldsAndUnfocus();
      SnackBar_Floating(context,
          text: "Memeber Added Succesfully !", color: Colors.green);
    } catch (e) {
      SnackBar_Floating(context,
          text: "Failed to add member:${e.toString()}", color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 40),
              child: CustomTiltle(
                text1: 'Enter',
                text2: 'details',
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  Text(
                    "First Name",
                    style: TextStyle(
                      color: Color(0xff030870),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: secondcustomtextfield(
                        prefixicon: Padding(
                          padding: EdgeInsets.only(left: 13, top: 10),
                          child: FaIcon(
                            FontAwesomeIcons.user,
                            size: 30,
                          ),
                        ),
                        hinttext: "enter your first name",
                        controller: _firstnamecontroller),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Last Name",
                    style: TextStyle(
                        color: Color(0xff030870),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  secondcustomtextfield(
                      prefixicon: Padding(
                        padding: EdgeInsets.only(left: 13, top: 10),
                        child: FaIcon(
                          FontAwesomeIcons.user,
                          size: 30,
                        ),
                      ),
                      hinttext: "enter your last name",
                      controller: _secondnamecontroller),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Birth of date",
                    style: TextStyle(
                        color: Color(0xff030870),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  secondcustomtextfield(
                      prefixicon: GestureDetector(
                        onTap: () async {
                          try {
                            DateTime? initialDate = _birthdatecontroller
                                    .text.isNotEmpty
                                ? DateTime.parse(_birthdatecontroller.text)
                                : DateTime
                                    .now(); // Fallback to today if text is empty or invalid
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2150),
                            );
                            // .then((date) {setState(() {
                            //   String formattedDate = DateFormat('yyyy-MM-dd').format(date!);
                            //   _birthdatecontroller.text=formattedDate;
                            // });
                            // });
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                _birthdatecontroller.text = formattedDate;
                              });
                            }
                          } catch (e) {
                            print("Error parsing date: $e");
                            setState(() {
                              _birthdatecontroller.text =
                                  DateFormat('yyyy-MM-dd')
                                      .format(DateTime.now());
                            });
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 13, top: 10),
                          child: FaIcon(
                            FontAwesomeIcons.calendarDays,
                            size: 30,
                          ),
                        ),
                      ),
                      hinttext: "pick a date",
                      controller: _birthdatecontroller),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Address",
                    style: TextStyle(
                        color: Color(0xff030870),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  secondcustomtextfield(
                      prefixicon: Padding(
                        padding: EdgeInsets.only(left: 13, top: 10),
                        child: FaIcon(
                          FontAwesomeIcons.addressBook,
                          size: 30,
                        ),
                      ),
                      hinttext: "enter your Address",
                      controller: _Adresscontroller),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Phone Number",
                    style: TextStyle(
                        color: Color(0xff030870),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  secondcustomtextfield(
                      prefixicon: Padding(
                        padding: EdgeInsets.only(left: 13, top: 10),
                        child: FaIcon(
                          FontAwesomeIcons.phone,
                          size: 22,
                        ),
                      ),
                      hinttext: "enter your phone number",
                      controller: _phoneNumbercontroller),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Fee",
                    style: TextStyle(
                        color: Color(0xff030870),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  secondcustomtextfield(
                      prefixicon: Padding(
                        padding: EdgeInsets.only(left: 13, top: 10),
                        child: FaIcon(
                          FontAwesomeIcons.moneyBill,
                          size: 26,
                        ),
                      ),
                      hinttext: "enter Fee",
                      controller: _feecontroller),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Registeration date",
                    style: TextStyle(
                        color: Color(0xff030870),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  secondcustomtextfield(
                      prefixicon: Padding(
                        padding: EdgeInsets.only(left: 13, top: 10),
                        child: FaIcon(
                          FontAwesomeIcons.calendarDays,
                          size: 30,
                        ),
                      ),
                      hinttext: "enter your registeration date",
                      controller: _registrerationcontroller),
                  SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                      label: "Confirm data",
                      onperssed: () {
                        addTrainer();
                      }),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
