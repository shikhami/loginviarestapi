import 'package:flutter/material.dart';
import 'package:loginscreen/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import './Providers/provider.dart';
import './screens/change_passwoed_screen.dart';
import './screens/gym_info_screen.dart';
import './screens/timeline_screen.dart';
import './login_screen.dart';
import './screens/splash_screen.dart';
import './screens/profile_screen.dart';
import './screens/gym_info_screen.dart';
import './screens/timeline_screen.dart';
//import 'half_circle.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: DataProvider(),
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home:GymInfoScreen(),
        routes: {
          ProfileScreen.routeName: (ctx) => ProfileScreen('', '', ''),
          ForgotPassword.routeName: (ctx) => ForgotPassword(),
          TimelineScreen.routeName: (ctx) => TimelineScreen(),
          GymInfoScreen.routeName: (ctx) => GymInfoScreen(),
        },
      ),
    );
  }
}
