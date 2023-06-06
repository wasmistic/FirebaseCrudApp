import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_app/common_widget/Customize_Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../colors/app_colors.dart';
import '../../routes/Routes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AllTask extends StatefulWidget {
  const AllTask({Key? key}) : super(key: key);

  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {

  final CollectionReference _product = FirebaseFirestore.instance.collection('Tasks');

  bool loading = false;
  int DocLength= 0;

  void setLoading(){
    setState(() {
      loading=true;
    });
  }

  void defaultLoading(){
    setState(() {
      loading=false;
    });
  }

  void DeleteTask(String TaskId)async{
    await _product.doc(TaskId).delete();
    defaultLoading();
  }

  @override
  Widget build(BuildContext context) {
    // print(_product.doc().length);
    return Scaffold(
      body: loading==false ? Container(
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
            SizedBox(height: 130.h,),
            Row(
              children: [
                GestureDetector(
                  onTap: ()=>Get.toNamed(AppRoute.getAllTask()),
                  child: Icon(Icons.home,color: AppColors.secondaryColor,),
                ),
                SizedBox(width: 10.w,),
                GestureDetector(
                  onTap: ()=>Get.toNamed(AppRoute.getAddTask()),
                  child: Container(
                    width: 23.w,
                    height: 23.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: AppColors.mainColor,
                    ),
                    child: Center(
                      child: Icon(Icons.add,color: AppColors.textHolder,size: 20.sp,),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Icon(Icons.calendar_month_sharp,color: AppColors.secondaryColor,),
                SizedBox(width: 10.w,),
                Text(
                  DocLength < 1 ? '0' : (DocLength-1).toString(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.secondaryColor,
                  ),
                )
              ],
            ),
            SizedBox(height: 40.h,),
            Expanded(
                child: StreamBuilder(
                  stream: _product.snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> StreamSnapshot) {
                    if(StreamSnapshot.hasData){
                      return ListView.builder(
                          padding:EdgeInsets.zero,
                          itemCount:StreamSnapshot.data!.docs.length,
                          itemBuilder:(_,index){
                            final DocumentSnapshot documentSnapshot = StreamSnapshot.data!.docs[index];
                            DocLength=StreamSnapshot.data!.docs.length;
                            return Dismissible(
                                background: _buildLeftIcon(),
                                secondaryBackground: _buildRightIcon(),
                                onDismissed: (DismissDirection direction){
                                  print('after dismissed');
                                },
                                confirmDismiss: (DismissDirection direction) async{
                                  if(direction==DismissDirection.startToEnd){
                                    _buildModal(documentSnapshot);
                                    return false;
                                  }else{
                                    setLoading();
                                    return Future.delayed(Duration(seconds: 5), ()async{
                                      DeleteTask(documentSnapshot.id);
                                      return direction==DismissDirection.endToStart;
                                    });
                                  }
                                },
                                key:ObjectKey(index),
                                child: Container(
                                  width: double.maxFinite,
                                  height: 50.h,
                                  margin: EdgeInsets.only(bottom:10.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.textHolder,
                                  ),
                                  child: Center(
                                    child: Text(
                                      documentSnapshot['name'],
                                      style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                )
                            );
                          });
                    }else{
                      return  Container(
                        width: double.maxFinite,
                        height: 50.h,
                        margin: EdgeInsets.only(bottom:10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.textHolder,
                        ),
                        child: Center(
                          child: Text(
                            'No Task',
                            style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      );
                    }
                  },

                )
            ),
          ],
        ),
      ) : _buildSpin(),
    );
  }

    Widget _buildLeftIcon(){
      return Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.only(left: 10.w),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColors.textHolder.withOpacity(0.5),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.r),
            topLeft: Radius.circular(10.r)
          )
        ),
        child: Icon(Icons.edit, color:AppColors.secondaryColor,),
      );
    }

    Widget _buildRightIcon(){
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.only(right: 10.w),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.r),
              topRight: Radius.circular(10.r)
          )
      ),
      child: Icon(Icons.delete, color:Colors.white,),
    );
  }

    Future _buildModal(DocumentSnapshot documentSnapshot){
      return showModalBottomSheet(
         backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          context: context,
          builder: (_){
        return Container(
          height: 250.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Color(0xFF2e3253).withOpacity(0.4),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: ()=> Get.toNamed(AppRoute.getSingleTask(), arguments: documentSnapshot),
                child: CustomizeButton(text: 'View', bg_color: AppColors.mainColor, text_color: AppColors.textHolder),
              ),
              SizedBox(height: 20.h,),
              GestureDetector(
                onTap: ()=> Get.toNamed(AppRoute.getUpdateTask(),arguments: documentSnapshot),
                child: CustomizeButton(text: 'Edit', bg_color: AppColors.mainColor, text_color: AppColors.textHolder),
              ),
            ],
          ),
        );
      });
    }

    Widget _buildSpin(){
      return SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: SpinKitThreeInOut(
          itemBuilder: (context, int index){
            return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: index.isEven ? Colors.red : Colors.green,
                )
            );
          },
        ),
      );
    }
}
