import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class GymInfoScreen extends StatefulWidget {
  static const routeName = '/gymInfo';
  @override
  _GymInfoScreenState createState() => _GymInfoScreenState();
}

class _GymInfoScreenState extends State<GymInfoScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title:Text('Gym Information')),
body: ListView(
  children: [
        SizedBox(
          height:250,
          width:800,
                  child: FittedBox(
            
                    child: Image.network('https://picsum.photos/250?image=9'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left:10.0,top:15,bottom:4),
          // padding: const EdgeInsets.all(2.0),
          child: Text('Website',style:TextStyle(
            fontSize: 15,
            
          )),
        ),
         Padding(
         padding: const EdgeInsets.only(left:10.0,top:5,bottom:4),
         //  padding: const EdgeInsets.all(2.0),
          child: Text('Business Email',style:TextStyle(
            fontSize: 15,
            
          )),
        ),

         Padding(
         // padding: const EdgeInsets.all(2.0),
           padding: const EdgeInsets.only(left:10.0,top:5,bottom:4),
          child: Text('name',style:TextStyle(
            fontSize: 15,
            
          )),
        ),
         Padding(
          padding: const EdgeInsets.only(left:10.0,top:5,bottom:4),
          child: Text('address',style:TextStyle(
            fontSize: 15,
            
          )),
        ),
           Center(
          child: new TextButton(
              onPressed: () => launch("tel://21213123123"),
              child: new Text("Contact")),
        ),
      
    SizedBox(height:20),
                 Center(child: 
               Text('or',style: TextStyle(color: Colors.black,),
               ),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    CircleAvatar(radius:20,backgroundImage: AssetImage('assets/images/facebook.png')),
                     CircleAvatar(radius:20,backgroundImage:AssetImage('assets/images/twitter.png'),),
                                    ],),
                ),  
  
  ],
),
    );
  }
}
