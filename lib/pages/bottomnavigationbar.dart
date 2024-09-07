import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/config/icons.dart';
import 'package:volt/cubits/get_bottom%20navbar_cubit/bottom_navbar_cubits.dart';
import 'package:volt/cubits/get_bottom%20navbar_cubit/bottom_navbar_state.dart';
import 'package:volt/pages/home_page.dart';
import 'package:volt/pages/settings.dart';
import 'package:volt/pages/viewmember.dart';
import 'package:volt/pages/viewtrainer.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  static String id = "BottomNavBar";
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
   late int _currentindex;
   @override
  void initState() {
    super.initState();
    _currentindex = 0; // Set the default index to 0 (HomePage)
  }

  

  late List<Widget> body = [
    HomePage(),
    Icon(Icons.menu),
    VeiwMember(),
    VeiwTrainer(),
    SettingPage()
  ];

  //  @override
  // void initState() {
  //   super.initState();
  //   body = [
  //     HomePage(onnavigatetomember:navigateToMemberPage, ),
  //     Icon(Icons.menu),
  //     memberpage()
  //   ];
  // }

  //  void navigateToMemberPage() {
  //   setState(() {
  //     _currentindex = 2; // Index of MemberPage
  //   });
  // }

  List<String> nameofpages = ["Home", "Menu", "person", "Train", "Settings"];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        if (state is TabSelectedState) {
          _currentindex = state.tabIndex;
        }

        return Scaffold(
          body: Center(child: body[_currentindex]),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blue[50],
            elevation: 0.0,
            showSelectedLabels: false,
            showUnselectedLabels: true,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            currentIndex: _currentindex,
            onTap: (int value) {
              // setState(() {
              //   _currentindex = value;
              // });

              BlocProvider.of<BottomNavBarCubit>(context).selectTab(value);
            },
            // items: [
            //   BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home",),
            //   BottomNavigationBarItem(icon: Icon(Icons.menu),label: "Menu",),
            //   BottomNavigationBarItem(icon: Icon(Icons.person),label: "person",),
            // ],
            items: [
              Icons.home,
              Icons.menu,
              Icons.person,
              fitness_center,
              Icons.settings
            ]
                .asMap()
                .map(
                  (key, value) => MapEntry(
                    key,
                    BottomNavigationBarItem(
                      label: nameofpages[key],
                      icon: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: _currentindex == key
                              ? Colors.blue[600]
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Icon(value),
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        );
      },
    );
  }
}
