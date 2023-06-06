import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/app_colors.dart';

class CustomizeButton extends StatelessWidget {
  final String text;
  final Color bg_color;
  final Color text_color;
   CustomizeButton({Key? key, required this.text, required this.bg_color, required this.text_color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width-50.sp,
      height: 45.h,
      decoration: BoxDecoration(
          color: bg_color,
          borderRadius: BorderRadius.circular(35.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(0, 1),
              spreadRadius: 3,
              blurRadius: 1,
            )
          ]
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18.sp,
              color:text_color,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );;
  }
}
