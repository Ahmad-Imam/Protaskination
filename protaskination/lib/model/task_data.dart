import 'package:flutter/cupertino.dart';
import 'package:protaskination/model/task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {

  List<Task> _taskList = [

  ];
  UnmodifiableListView<Task> get taskList
  {
    return UnmodifiableListView(_taskList);
  }
  int get taskCount{
    return _taskList.length;
  }

  void addTask(String newTaskTitle, String taskDateTime)
  {
    _taskList.add(Task(name: newTaskTitle,taskDateTime: taskDateTime));
    //_taskList.insert(index, element)
    notifyListeners();
  }

  // void addDate(String newDate)
  // {
  //   _taskList.add(Task(taskDate: newDate));
  //   //_taskList.insert(index, element)
  //   notifyListeners();
  // }

  void editTask(int index,String newTaskTitle,String datetime)
  {
    String prevDateTime =_taskList[index].taskDateTime;
    //String prevTime = _taskList[index].taskTime;
    _taskList.removeAt(index);
    if(datetime==null) {
      datetime=prevDateTime;
    }
    _taskList.insert(index,Task(name: newTaskTitle,taskDateTime: datetime));

    //_taskList.insert(index, element)
    notifyListeners();
  }

  void updateTask(Task task){
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task)
  {
    _taskList.remove(task);
    notifyListeners();
  }


}
