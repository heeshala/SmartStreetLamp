import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smartstreetlamp/pages/data.dart';
import 'package:smartstreetlamp/pages/login.dart';
import 'package:smartstreetlamp/pages/ologin.dart';
import 'package:smartstreetlamp/pages/owner.dart';
import 'package:smartstreetlamp/pages/technician.dart';
import 'package:smartstreetlamp/pages/technicianhome.dart';
import 'package:smartstreetlamp/pages/tlogin.dart';

import 'pages/technician.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async  {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   //FirebaseMessaging.instance.getToken();
   //var tok= await FirebaseMessaging.instance.getToken();
   //print(tok);
   //DatabaseReference databaseReference= new FirebaseDatabase().reference();
   //databaseReference.child('fcm-token/$tok').set({"token":tok});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // 
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
          duration: 1000,
          splash: Text('Lamp'),
          
          nextScreen: OLogin(),
          splashTransition: SplashTransition.fadeTransition,
          
          backgroundColor: Colors.blue[800],
        )
    );
  }
}

