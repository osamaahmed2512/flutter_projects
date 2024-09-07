
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({
    super.key, required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      // backgroundColor:Color(0xff030870) ,
      elevation: 0,
      title: Text(name),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:[Color(0xff67A8FE) ,Color(0xff67A8FE).withOpacity(0.5) ] ,
            begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                // stops: [0.0, 1.0],
                tileMode: TileMode.clamp
            ), 
        ),
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}