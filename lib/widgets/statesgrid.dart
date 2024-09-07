import 'package:flutter/material.dart';
import 'package:volt/models/sizeconfig.dart';

class StatesGrid extends StatelessWidget {
  const StatesGrid({
    super.key, required this.imagepath, required this.title, required this.count,  this.top=0, this.bottom=0, required this.ontap,
  });

  final String imagepath ;
  final String title;
  final double count;
  final double top;
  final double bottom;
  final  ontap ; 
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GestureDetector(
      onTap:ontap ,
      child: Padding(
        padding:  EdgeInsets.only(
           top:top ,
           bottom:bottom ,
           left: 20,
          //  left: SizeConfig.safeBlockHorizontal*1.5,
          //  right:SizeConfig.safeBlockHorizontal*1.5,
           right: 20
        ),
        child: Container( 
          width: 155,
          height: 170,
          // width: SizeConfig.safeBlockHorizontal * 10 ,// Example usage
          // height: SizeConfig.safeBlockVertical * 22,  // Example usage
          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors:[Color(0xff67A8FE) ,Color(0xff67A8FE).withOpacity(0.59)] ,
            // stops: [0.0,0.1],
            begin: Alignment.topLeft,
                end: Alignment.bottomRight,
            ),
            color: Color(0xff67A8FE),
          
          ),
          child: Padding(
            padding:  EdgeInsets.only(
              // top:SizeConfig.blockSizeVertical*1,
              top: 10,
              bottom: 10,
              // bottom: SizeConfig.blockSizeVertical*1,
              
            ),
            child: Center(
              child: Column(
                children:<Widget> [
                  Image.asset(
                    imagepath,
                    width: 90.0,
                    // width:SizeConfig.safeBlockHorizontal * 5.5 ,
                  ),
                  SizedBox(
                    height: 10,
                    // height: SizeConfig.blockSizeVertical*1,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    // height: SizeConfig.blockSizeVertical*1,
                  ),
                   Text(
                    count.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
