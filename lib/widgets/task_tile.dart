import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:protaskination/screens/edit_task_screen.dart';

class TaskTile extends StatelessWidget {
  final String taskTitle;
  final String datetime;
  final bool isChecked;

  final Function checkboxCallback;
  final Function onLongPRessCallback;
  final Function onTapCallback;
  int taskno;

  TaskTile(
      {this.taskTitle,
      this.isChecked,
      this.checkboxCallback,
      this.onLongPRessCallback,
      this.onTapCallback,
      this.taskno,
      this.datetime});

  @override
  // void toogleState(bool checkstate) {
  //   setState(() {
  //     isChecked = checkstate;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPRessCallback,
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => EditTaskScreen(taskno: taskno),
        );
      },
      leading: Text(
        '${taskno+1}. ',
        style: TextStyle(
          fontSize: 20,
            fontWeight: FontWeight.bold,
            decoration: isChecked ? TextDecoration.lineThrough : null,
            color: isChecked ? Colors.red : Colors.deepPurpleAccent),
      ),
      title: Text(
        '$taskTitle',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: isChecked ? TextDecoration.lineThrough : null,
            color: isChecked ? Colors.red : Colors.deepPurpleAccent),
      ),
      subtitle: (Text(
        '$datetime',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: isChecked ? TextDecoration.lineThrough : null,
            color: isChecked ? Colors.red : Colors.deepPurpleAccent),
      )),
      trailing: Checkbox(
        value: isChecked,
        activeColor: Colors.white,
        checkColor: Colors.deepPurpleAccent,
        onChanged: checkboxCallback,
      ),
    );
  }
}
