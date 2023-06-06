import 'package:firebase_crud_app/colors/app_colors.dart';
import 'package:firebase_crud_app/routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common_widget/Customize_Button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         padding: EdgeInsets.symmetric(vertical: 120.h),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/img/header.jpg'),
            )
        ),
        child: Column(
          children: [
            _buildWelcomeText(),
            Expanded(child: Container(),),
            GestureDetector(
              onTap: ()=> Get.toNamed(AppRoute.getAddTask()),
              child:  CustomizeButton(text: 'Add Task',bg_color: AppColors.mainColor,text_color: AppColors.textHolder,),
            ),
            SizedBox(height: 20.h,),
           GestureDetector(
            onTap: ()=> Get.toNamed(AppRoute.getAllTask()),
             child:  CustomizeButton(text: 'View All',bg_color: AppColors.textHolder,text_color: AppColors.mainColor,),
           )
          ],
        ),
      ),
    );
  }
  // AllTask
  Widget _buildWelcomeText(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      child: RichText(
          text: TextSpan(
              text: 'Hello',
              style: TextStyle(
                fontSize: 60.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor,
              ),
              children: [
                TextSpan(
                  text:'\n Start your beautiful day',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color:AppColors.smallTextColor,
                  ),
                )
              ]
          )
      ),
    );
  }


}
