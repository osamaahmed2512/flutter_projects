// import 'package:flutter/material.dart';
// import 'package:volt/pages/home_page.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   State<_BottomNavBarState> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//    int _currentindex=0;
//    List<Widget> body = const [
//     HomePage(),
//     Icon(Icons.menu),
//     Icon(Icons.person),
//    ];

//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//     body: body[_currentindex],
//     bottomNavigationBar:BottomNavigationBar(
//     currentIndex: _currentindex,
//     onTap: (int value) {
//       setState(() {
//         _currentindex=value;
//       });
//     },
//     items: [
//       BottomNavigationBarItem(icon: Icon(Icons.home)),
//       BottomNavigationBarItem(icon: Icon(Icons.menu)),
//       BottomNavigationBarItem(icon: Icon(Icons.person)),
//     ],
//     ),
//   );
//   }
// }