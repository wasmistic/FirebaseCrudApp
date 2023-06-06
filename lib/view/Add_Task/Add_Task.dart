import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_app/colors/app_colors.dart';
import 'package:firebase_crud_app/controller/AppSnack.dart';
import 'package:firebase_crud_app/routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common_widget/Customize_Button.dart';
import '../../common_widget/Customize_TextField.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  final CollectionReference _product = FirebaseFirestore.instance.collection('Tasks');

  TextEditingController name = TextEditingController();
  TextEditingController detail = TextEditingController();

  bool loading =false;

  void AddTask()async{
    loading = true;
    final String Taskname=name.text;
    final String Taskdetail = detail.text;

    await _product.add({'name':Taskname, 'details':Taskdetail});
    name.text='';
    detail.text='';
    Get.toNamed(AppRoute.getAllTask());
    loading = false;
  }

  bool CheckText(){
    if(name.text.trim()=='' || detail.text.trim()==''){
      AppSnack.getSnackBar('Title or Body is missing', 'Fill all input field');
      return false;
    }else if(name.text.trim().length < 3){
      AppSnack.getSnackBar('Title', 'Title must be greater than two characters');
      return false;
    }else if(detail.text.trim().length < 5){
      AppSnack.getSnackBar('Body text', 'Body text must be greater than 5 characters');
      return false;
    }
    else{
      return true;
    }
  }


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
              CustomizeTextField(text: 'Enter task name or title',cont_h: 45.h, icon: Icons.task_sharp,maxh: 1,textController: name),
              SizedBox(height: 20.h,),
              CustomizeTextField(text: 'Enter task details',cont_h: 155.h,maxh: 6,textController:detail),
              SizedBox(height: 15.h,),
              loading==true ? _buildSpinner() :
              GestureDetector(
                onTap: (){
                  if(CheckText()){
                    AddTask();
                  }
                },
                child:CustomizeButton(text_color: AppColors.textHolder, bg_color: AppColors.mainColor,text: 'Add',),
              )

            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSpinner(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45.h,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColors.textHolder,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.mainColor,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
