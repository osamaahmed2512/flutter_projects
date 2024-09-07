
// import 'package:flutter/material.dart';
// import 'package:volt/config/palette.dart';

// class CustomTitle extends StatelessWidget {
//   const CustomTitle({
//     super.key, required this.title,
//   });
//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 25),
//         child: Center(
//           child: Text(
//             title,
//             style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold),
      
//           ),
//         ),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//           bottomRight: Radius.circular(30),
//           bottomLeft: Radius.circular(30)
//         ),
//         color: palette.secondarycolor,
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';

class CustomTiltle extends StatelessWidget {
  const CustomTiltle({
    super.key, required this.text1, required this.text2,
  });
  final String text1,text2;

  @override
  Widget build(BuildContext context) {
    return    Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [

            Text(
             text1+" ",
             style: TextStyle(
                 color: Color(0xff030870),
                 fontSize: 30,
                 fontWeight: FontWeight.w600),
           ),
            Text(
             text2,
             style: TextStyle(
                 color: Color(0xffE10000),
                 fontSize: 30,
                 fontWeight: FontWeight.w600),
           )
         ],
       );
  }
}
