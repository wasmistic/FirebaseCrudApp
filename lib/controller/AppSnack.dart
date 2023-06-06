import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppSnack{
  static  getSnackBar(String title, body){
    Get.snackbar(title, body,
      backgroundColor: AppColors.mainColor,
      titleText: Text(title,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: Colors.white
        ),),
      messageText: Text(
        body,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: Colors.yellowAccent
        ),
      ),
    );
  }
}
