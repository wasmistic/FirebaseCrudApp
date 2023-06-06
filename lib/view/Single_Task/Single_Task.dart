
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_app/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common_widget/Customize_TextField.dart';



class SingleTask extends StatelessWidget {
  final DocumentSnapshot? documentSnapshot;
  SingleTask({Key? key, this.documentSnapshot}) : super(key: key);



  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 40.h, left:20.w, right: 20.w),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/img/addtask.jpg')
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30.w,
                height: 30.h,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                child: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_sharp,color: AppColors.mainColor,),
                ),
              ),
              SizedBox(height: 180.h,),
              CustomizeTextField(text: documentSnapshot?['name']?? 'Enter name',cont_h: 45.h, icon: Icons.task_sharp,maxh: 1,),
              SizedBox(height: 20.h,),
              CustomizeTextField(text: documentSnapshot?['details']?? 'Enter task details',cont_h: 155.h,maxh: 6,),
              // SizedBox(height: 15.h,),
              // CustomizeButton(text_color: AppColors.textHolder, bg_color: AppColors.mainColor,text: 'Update',),

            ],
          ),
        ),
      )
    );
  }


}
