import 'package:flutter/material.dart';
import 'package:protaskination/model/task.dart';
import 'package:protaskination/model/task_data.dart';
import 'package:protaskination/widgets/task_tile.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<TaskData>(
        builder: (context, taskData, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return TaskTile(
                datetime: taskData.taskList[index].taskDateTime,
                taskno: index,
                taskTitle: taskData.taskList[index].name,
                isChecked: taskData.taskList[index].isDone,
                checkboxCallback: (bool checkState) {
                  if(checkState) {
                    SnackBar snackbar = SnackBar(
                        content: Text('Hold to remove task'));
                    Scaffold.of(context).showSnackBar(snackbar);
                  }
                  taskData.updateTask(taskData.taskList[index]);
                },
                onLongPRessCallback: (){
                  //print('in task list ${taskData.taskList[index].taskDate}');
                taskData.deleteTask(taskData.taskList[index]);
                },
              );
            },
            itemCount: taskData.taskCount,
          );
        },
      ),
    );
  }
}
