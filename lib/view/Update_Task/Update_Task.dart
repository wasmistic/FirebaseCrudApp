import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_app/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common_widget/Customize_Button.dart';
import '../../common_widget/Customize_TextField.dart';
import '../../controller/AppSnack.dart';
import '../../routes/Routes.dart';


class UpdateTask extends StatefulWidget {
  final DocumentSnapshot? documentSnapshot;
   UpdateTask({Key? key,this.documentSnapshot}) : super(key: key);

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController name = TextEditingController();
  TextEditingController detail = TextEditingController();

  bool loading =false;

  final CollectionReference _product = FirebaseFirestore.instance.collection('Tasks');

  void Update(DocumentSnapshot? documentSnapshot)async{
    final String Taskname= name.text;
    final String Taskdetail = detail.text;

    await _product.doc(documentSnapshot!.id)
    .update({'name':Taskname, 'details':Taskdetail});
    Get.offAllNamed(AppRoute.getAllTask());
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
    name.text=widget.documentSnapshot?['name'];
    detail.text=widget.documentSnapshot?['details'];
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
              CustomizeTextField(text: 'Enter name',cont_h: 45.h, icon: Icons.task_sharp,maxh: 1,textController: name,),
              SizedBox(height: 20.h,),
              CustomizeTextField(text:'Enter task details',cont_h: 155.h,maxh: 6,textController: detail,),
              SizedBox(height: 15.h,),
              loading==true ? _buildSpinner() :
              GestureDetector(
                onTap: (){
                  if(CheckText()){
                    Update(widget.documentSnapshot);
                  }},
                child:  CustomizeButton(text_color: AppColors.textHolder, bg_color: AppColors.mainColor,text: 'Update',),
              )
            ],
          ),
        ),
      )
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
