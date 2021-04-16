import './text_capital.dart';
import './splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './change_passwoed_screen.dart';

class ProfileScreen extends StatefulWidget {
  // This widget is the root of your application.
  final String name;
  final String email;
  final String img;

  ProfileScreen(this.name, this.email, this.img);
  static const routeName = '/profileScreen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6FCFF),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFF2739EF),
            title: Text('Profile'),
          ),
        ),
        body: ListView(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF2739EF),
                      offset: Offset(0, 2),
                      //blurRadius: 4,
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF2739EF),
                      Color(0xFF2739EF),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0, 1],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white10,
                          minRadius: 60.0,
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: widget.img.isNotEmpty
                                ? NetworkImage(widget.img)
                                : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
    Text(
                      makeFirstLetterCapital('${widget.name}'),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
   ),
                    Text(
                      widget.email,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 2.0,
              margin: EdgeInsets.only(
                left: deviceWidth(context) * 0.05,
                right: deviceWidth(context) * 0.05,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.lock_outline,
                      color: Color(0xFF2739EF),
                    ),
                    title: Text(
                      "Change Password",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF2D2F3B),
                      ),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).pushNamed(ForgotPassword.routeName);
                    },
                  ),
                  _buildDivider(),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Color(0xFF2739EF),
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF2D2F3B),
                      ),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      logOut();
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }

  logOut() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Row(
            children: [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(
                width: 5,
              ),
              SingleChildScrollView(
                child: Text(
                  'Logout !',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF2D2F3B),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to Logout ?',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFF2D2F3B),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Navigator.pop(context, false);
                Navigator.of(
                  context,
                  // rootNavigator: true,
                ).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Navigator.pop(context, true);
                setState(() {
                  // print(id);
                  // orders.removeAt(index);
                  Navigator.of(
                    context,
                    // rootNavigator: true,
                  ).pop(true);
                  showLoadingSpinner();
                  removeToken();
                });
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void showLoadingSpinner() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              Text('     Please wait'),
            ],
          ),
        ),
      ),
    );
  }

  void removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token').then((value) => {
          Navigator.pop(context),
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext ctx) => AnimatedSplashScreen())),
        });
  }
}
