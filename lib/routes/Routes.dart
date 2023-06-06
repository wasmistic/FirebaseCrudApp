import 'package:cloud_firestore/cloud_firestore.dart';

import '../view/All_Task/All_Task.dart';
import '../view/Home_Screen/Home_Page.dart';
import 'package:get/get.dart';

import '../view/Add_Task/Add_Task.dart';
import '../view/Single_Task/Single_Task.dart';
import '../view/Update_Task/Update_Task.dart';


class AppRoute{
  static String home = '/';
  static String allTask = '/allTask';
  static String addTask = '/addTask';
  static String updateTask = '/updateTask';
  static String singleTask = '/singleTask';

  static String getHome()=>home;
  static String getAllTask()=>allTask;
  static String getAddTask()=>addTask;
  static String getUpdateTask()=>updateTask;
  static String getSingleTask()=>singleTask;


  static List<GetPage> routes = [
    GetPage(name: home, page:()=>const HomePage()),
    GetPage(name: allTask, page:()=>const AllTask(), transition:Transition.zoom, transitionDuration: Duration(milliseconds:500)),
    GetPage(name: addTask, page:()=>const AddTaskPage(), transition:Transition.zoom, transitionDuration: Duration(milliseconds:500)),
    GetPage(name: updateTask, page:(){
      DocumentSnapshot documentSnapshot = Get.arguments;
      return  UpdateTask(documentSnapshot:documentSnapshot);
    }, transition:Transition.zoom, transitionDuration: Duration(milliseconds:500)),
    GetPage(name: singleTask, page:(){
      DocumentSnapshot documentSnapshot = Get.arguments;
      return SingleTask(documentSnapshot:documentSnapshot);
    },transition:Transition.zoom, transitionDuration: Duration(milliseconds:500)),
  ];

}