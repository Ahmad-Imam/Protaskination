import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:protaskination/model/task_data.dart';
import 'package:provider/provider.dart';
import 'package:protaskination/model/task_data.dart';
import 'screens/task_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  if(!kIsWeb){
    var initialize = AndroidInitializationSettings('protask');

    var initializeSettings = InitializationSettings(android: initialize);

    await flutterLocalNotificationsPlugin.initialize(initializeSettings,onSelectNotification: (String payload)async{
      if(payload!=null)
        debugPrint('noti payload'+ payload);
    });
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TaskData(),
      child: MaterialApp(
        home: TaskScreen(),
      ),
    );
  }
}
