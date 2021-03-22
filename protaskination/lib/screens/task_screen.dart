import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:protaskination/model/task.dart';
import 'package:protaskination/model/task_data.dart';
import 'package:protaskination/screens/add_task_screen.dart';
import 'package:protaskination/screens/loading_screen.dart';
import 'package:protaskination/widgets/task_list.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          showModalBottomSheet(
            // isScrollControlled: true,
            context: context,
            builder: (context) => AddTaskScreen(),
          );
        },
        child: GlowIcon(
          Icons.add_box_rounded,
          glowColor: Colors.black,
        ),
      ),
      backgroundColor: Color(0xff8d25e0),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: Image(
                          color: Colors.white,
                          image: AssetImage('images/protask.png'),
                        ),
                      ),
                      IconButton(
                        icon: CircleAvatar(
                          child: Icon(
                            Icons.location_on,
                            color: Color(0xff8d25e0),
                            size: 30,
                          ),
                          backgroundColor: Colors.white,
                          radius: 30,
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoadingScreen();
                          }));
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GlowText(
                    "Protaskination",
                    style: GoogleFonts.varela(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    glowColor: Colors.deepPurpleAccent,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GlowText(
              "Tasks : ${Provider.of<TaskData>(context).taskCount}",
              style: GoogleFonts.varela(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              glowColor: Colors.deepPurpleAccent,
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: GlowContainer(
                glowColor: Colors.deepPurpleAccent,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: TaskList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
