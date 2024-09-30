import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volt/helper/snackbar_floating.dart';
import 'package:volt/helper/utils.dart';
import 'package:volt/widgets/custombutton.dart';
import 'package:volt/widgets/customtextfield2.dart';
import 'package:volt/widgets/customtitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:volt/widgets/customupload_image%20.dart';

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

  Uint8List? _image;
 String? _uploadedImageUrl;
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
     if (_uploadedImageUrl == null) {
      snackBarFloating(context, text: "Image not uploaded yet", color: Colors.red);
      return;
    }
    try {
      await trainers.add({
        'first_name': _firstnamecontroller.text, // John Doe
        'last_name': _secondnamecontroller.text, // John Doe
        'address': _Adresscontroller.text, // Stokes and Sons
        'phonenumber': _phoneNumbercontroller.text,
        'registerationdate': _registrerationcontroller.text,
        'fee': _feecontroller.text,
        'birthdatecontroller': _birthdatecontroller.text,
        'imageurl': _uploadedImageUrl,
      });
      clearFieldsAndUnfocus();
      snackBarFloating(context,
          text: "Memeber Added Succesfully !", color: Colors.green);
    } catch (e) {
      snackBarFloating(context,
          text: "Failed to add member:${e.toString()}", color: Colors.red);
    }
  }

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img;
      });
      await uploadImageAndSaveData();
    } else {
       setState(() {
        _image = null;
      });
      snackBarFloating(context, text: "No image selected", color: Colors.red);
    }
  }

   Future<void> uploadImageAndSaveData() async{
    if (_image !=null) {
      try {
  String imageName =  "${DateTime.now().microsecondsSinceEpoch}.jpg";
      
  Reference ref = FirebaseStorage.instance.ref().child("member_images/$imageName");  
  UploadTask uploadTask = ref.putData(_image!); // <-- Upload image to Firebase Storage
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL(); // <-- Get image URL from Firebase Storage
  
     setState(() {
          _uploadedImageUrl = downloadUrl; // Store the image URL
        });
    
} catch (e) {
        snackBarFloating(context, text: "Image upload failed: ${e.toString()}", color: Colors.red);
      }
    }  else {
      snackBarFloating(context, text: "Please select an image", color: Colors.red);
    }

  }

    void _deleteImage(){
    setState(() {
        ImageCache().clear();
      _image =  null;
      _uploadedImageUrl = null; 
    });
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
                  UploadImage(
                    image: _image,
                    selectImage: selectImage,
                    deleteImage: _deleteImage,
                  ),
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
