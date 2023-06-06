import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/app_colors.dart';

class CustomizeTextField extends StatelessWidget {
  final String text;
  final double cont_h;
  final IconData? icon;
  final int maxh;
  final TextEditingController? textController;
  CustomizeTextField({Key? key, required this.text, required this.cont_h, this.icon, required this.maxh, this.textController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      height: cont_h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.smallTextColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextField(
        autocorrect: false,
        autofocus: false,
        maxLines: maxh,
        controller: textController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 20.sp),
          hintText: text,
          hintStyle: TextStyle(
              fontSize: 16.sp,
              color: AppColors.mainColor
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }
}
