import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/config/palette.dart';
import 'package:volt/cubits/get_bottom%20navbar_cubit/bottom_navbar_cubits.dart';
import 'package:volt/models/sizeconfig.dart';
import 'package:volt/widgets/customappbar.dart';
import 'package:volt/widgets/statesgrid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, });
  @override
  Widget build(BuildContext context) {
     SizeConfig.init(context);
    return Scaffold(
      backgroundColor: palette.primarycolor,
      appBar: CustomAppBar(name: "Dashboard"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatesGrid(
                    ontap: (){},
                    imagepath:
                        "assets/images/increase_presentation_Profit_growth-512.png",
                    title: "Income",
                    count: 4500,
                    // top: SizeConfig.blockSizeVertical*5.1,
                    top: 40,
                    bottom: 20,
                    // bottom: SizeConfig.blockSizeVertical*5.1,
                  ),
                  StatesGrid(
                    ontap: (){},
                    imagepath:
                        "assets/images/decrease_presentation_down_loss-512.png",
                    title: "expence",
                    count: 4500,
                    top: 40,
                    // top:  SizeConfig.blockSizeVertical*5.1,
                    bottom: 20,
                    // bottom:  SizeConfig.blockSizeVertical*5.1,
                  ),
                ],
              ),
            ),
             Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatesGrid(
                    ontap: (){
                      BlocProvider.of<BottomNavBarCubit>(context).selectTab(2);
                    },
                    imagepath:
                        "assets/images/family_tree_members_people-512.png",
                    title: "Members",
                    count: 4500,
                    top: 0,
                    // top:  SizeConfig.blockSizeVertical*2.5,
                    
                  ),
                  StatesGrid(
                   ontap: () =>BlocProvider.of<BottomNavBarCubit>(context).selectTab(3),
                    imagepath:
                        "assets/images/gym_coach_trainer_fitness-512.png",
                    title: "Trainers",
                    count: 4500,
                    top: 0,
                    // top:  SizeConfig.blockSizeVertical*2.5,
                  ),
                ],
              ),
              StatesGrid(
                ontap: (){},
                    imagepath:
                        "assets/images/dumbbell_gym_fitness_exercise-512.png",
                    title: "equipment",
                    count: 4500,
                    top: 20,
                    // top: SizeConfig.blockSizeVertical*2.5,
                    bottom: 20,
                    // bottom: SizeConfig.blockSizeVertical*2.5,
                  ),
          ],
        ),
      ),
    );
  }
}
