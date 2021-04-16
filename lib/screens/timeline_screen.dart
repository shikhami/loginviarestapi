import 'package:flutter/material.dart';

class TimelineScreen extends StatefulWidget {
  static const routeName = '/timelineScreen';
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Timeline Data')),
body: ListView(
  children: [
        SizedBox(
          height:250,
          width:800,
                  child: FittedBox(
            
                    child: Image.network('https://regalmojo.in/gymeDiary/media/gym-REGALM1613664912153/profilePicture/mediaFile-1613719835727.jpeg'),
          ),
        ),
  ]
),
    );
  }
}
