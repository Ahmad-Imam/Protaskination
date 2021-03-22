import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:protaskination/main.dart';
import 'package:protaskination/model/task.dart';
import 'package:protaskination/model/task_data.dart';
import 'package:protaskination/screens/task_screen.dart';
import 'package:protaskination/widgets/task_list.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime dateTime = DateTime.now();
  TimeOfDay timeOfDay;

  String formatteddate;
  String formattedTimeOfDay;

  TextEditingController _controller1;

  String _valueToValidate1 = '';
  String _valueSaved1 = '';

  // String _valueChanged1 = DateTime.now().toLocal().toString();

  String _valueChanged1 = DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now());

  String textFieldTask;
  KeyboardVisibilityNotification keyboardVisibilityNotification =
      new KeyboardVisibilityNotification();

  Future<bool> onBackPressed() {
    print('changed');
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    print('_valueChanged1 init  $_valueChanged1');
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print('ONCHANGE init : $visible');
        if (!visible) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        }
      },
      // onHide: (bool visible) {
      //   print('onHide : $visible');
      // },
    );
    _controller1 = TextEditingController(text: DateTime.now().toString());
    super.initState();
  }

  void scheduleAlarm() async {
    var scheduledNotificationDateTime =
        DateTime.parse(_controller1.text).add(Duration(seconds: 5));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'protask',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('protask'),
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0,
        '$textFieldTask',
        '${_controller1.text}',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Container(
              //color: Color(0xff757575),
              color: Color(0xff757575),
              //constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
              // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.top),
              child: Form(
                key: _formKey,
                child: Container(
                  //constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
                  //height: 300,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                        child: GlowText(
                          "Create Your Task",
                          style: GoogleFonts.varela(
                            textStyle: TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          blurRadius: 1,
                          glowColor: Colors.deepPurple,
                        ),
                      ),
                      TextFormField(
                        //focusNode: focusNode,
                        //autofocus: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.deepPurple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurpleAccent, width: 3.0),
                          ),
                          errorStyle: GoogleFonts.nobile(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (s) {
                          setState(() {
                            textFieldTask = s;
                            //print(s);
                          });
                          //return focusNode.requestFocus();
                        },

                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please type something!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      DateTimePicker(
                        type: DateTimePickerType.dateTimeSeparate,
                        dateMask: 'd MMM, yyyy',
                        controller: _controller1,
                        //initialValue: _initialValue,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        icon: Icon(Icons.event),
                        dateLabelText: 'Date',
                        timeLabelText: "Hour",
                        use24HourFormat: true,
                        //locale: Locale('pt', 'BR'),
                        selectableDayPredicate: (date) {
                          if (date.weekday == 6 || date.weekday == 7) {
                            return false;
                          }
                          return true;
                        },
                        onChanged: (val) => setState(() {
                          _valueChanged1 = val;
                          print('Cjh: $_valueChanged1');
                        }),
                        validator: (val) {
                          setState(() => _valueToValidate1 = val ?? '');
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            _valueSaved1 = val ?? '';
                            print('Saved: $_valueSaved1');
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  // background color
                                  primary: Colors.deepPurple,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  textStyle: TextStyle(fontSize: 20),
                                ),
                                child: Text(
                                  'Create',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  // print('CTT: ${_controller1.text}');
                                  if (_formKey.currentState.validate()) {
                                    if (textFieldTask != null &&
                                        _controller1.text.isNotEmpty) {
                                      Provider.of<TaskData>(context,
                                              listen: false)
                                          .addTask(textFieldTask, _valueChanged1);
                                      print('pressed $textFieldTask');

                                      if (!kIsWeb) {
                                        scheduleAlarm();
                                      }
                                      Navigator.pop(context);
                                    } else if (textFieldTask == null) {
                                      SnackBar snackbar = SnackBar(
                                          content:
                                              Text('Please enter your task'));
                                      Scaffold.of(context).showSnackBar(snackbar);
                                    }
                                  }
                                }),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          // IconButton(
                          //     icon: Icon(
                          //       Icons.date_range_sharp,
                          //       color: Colors.deepPurple,
                          //       size: 35,
                          //     ),
                          //     onPressed: () {
                          //       showDatePicker(
                          //         context: context,
                          //         initialDate: DateTime.now(),
                          //         firstDate: DateTime(2021),
                          //         lastDate: DateTime(2031),
                          //       ).then((date) {
                          //         if (date != null) {
                          //           setState(() {
                          //             dateTime = date;
                          //             print(dateTime);
                          //             formatteddate = DateFormat.yMMMMEEEEd()
                          //                 .format(dateTime)
                          //                 .toString();
                          //           });
                          //           //print('data $dateTime');
                          //           // print('ok fine $formatteddate');
                          //           // Provider.of<TaskData>(context, listen: false)
                          //           //     .addDate(formatteddate);
                          //         } else
                          //           print('hahah');
                          //
                          //         // DateTime now = new DateTime.now();
                          //         // DateTime dates = new DateTime(now.year, now.month, now.day);
                          //         // String formatteddates = DateFormat.yMMMMEEEEd().format(now).toString();
                          //         //
                          //         // print ('date is $formatteddates');
                          //       });
                          //     }),
                          // IconButton(
                          //     icon: Icon(
                          //       Icons.watch_later_outlined,
                          //       color: Colors.deepPurple,
                          //       size: 35,
                          //     ),
                          //     onPressed: () {
                          //       showTimePicker(
                          //               context: context,
                          //               initialTime: TimeOfDay.now())
                          //           .then((date) {
                          //         if (date != null) {
                          //           setState(() {
                          //             timeOfDay = date;
                          //             print(timeOfDay);
                          //             final localizations =
                          //                 MaterialLocalizations.of(context);
                          //             formattedTimeOfDay = localizations
                          //                 .formatTimeOfDay(timeOfDay);
                          //
                          //             print(formattedTimeOfDay);
                          //           });
                          //           //print('data $dateTime');
                          //           // print('ok fine $formatteddate');
                          //           // Provider.of<TaskData>(context, listen: false)
                          //           //     .addDate(formatteddate);
                          //         } else
                          //           print('hahah');
                          //
                          //         // DateTime now = new DateTime.now();
                          //         // DateTime dates = new DateTime(now.year, now.month, now.day);
                          //         // String formatteddates = DateFormat.yMMMMEEEEd().format(now).toString();
                          //         //
                          //         // print ('date is $formatteddates');
                          //       });
                          //     }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
