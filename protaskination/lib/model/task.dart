

import 'package:intl/intl.dart';

class Task{

  final String name;
  bool isDone;
  // static final DateTime now = new DateTime.now();
  // dynamic iniDate = DateFormat.yMMMMEEEEd().format(now).toString();
  //
  //
  // final DateTime date = new DateTime(now.year, now.month, now.day);
  // dynamic formatteddate = DateFormat.yMMMMEEEEd().format(now).toString();

  final String taskDateTime;

  Task({this.name,this.isDone=false,this.taskDateTime});

  void toggleDone()
  {


    isDone=!isDone;

  }



}