import 'package:email_validator/email_validator.dart';
import 'package:loginscreen/screens/profile_screen.dart';
import '../Providers/provider.dart';
//import '../Screens/Profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _loginType = TextEditingController();
  TextEditingController _pass = TextEditingController();
  Map<String, String> credentials = {'Email': '', 'Password': '','contact':'','loginType':''};
  final FocusNode _password = FocusNode();
  //final FocusNode _contactNo = FocusNode();
  final FocusNode _logintype = FocusNode();
  bool _passwordVisible = false;
  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    // final DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
      body: _buildPageContent(),
    );
  }

  Widget _buildPageContent() {
    return Container(
      height: deviceHeight(context),
      width: deviceWidth(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF2143FF), Color(0xff001381)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 150),
          Center(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 40),
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    margin:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          'Login',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFFFE8B88)),
                        )),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please input your Email';
                                  }
                                  //  if (EmailValidator.validate(value) == false) {
                                  //  return 'Invalid email';
                                  // }
                                  return null;
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_password);
                                },
                                onSaved: (newValue) {
                                  credentials['loginUserName'] = newValue;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.email,
                                      color: Color(0xff373941),
                                    ),
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xff373941),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    hintText: 'Enter Email Id',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Color(0xff373941))),
                               // keyboardType: TextInputType.emailAddress,
                                controller: _email,
                              ),
                              SizedBox(
                                height: deviceHeight(context) * 0.01,
                              ),
                              TextFormField(
                                 
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Color(0xff373941),
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    
                                    icon: Icon(Icons.lock,
                                        color: Color(0xff373941)),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff373941)),
                                    hintText: "Enter Password",
                                    hintStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Color(0xff373941))),
                                textInputAction: TextInputAction.done,

                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please input your Password';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  credentials['loginPassword'] = newValue;
                                },
                               
                                maxLines: 1,
                                obscureText: !_passwordVisible,
                                keyboardType: TextInputType.visiblePassword,
                                controller: _pass,
                                    onFieldSubmitted: (value) async {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  await loginParentUser();
                                },
                              ),
                              SizedBox(
                                height: deviceHeight(context) * 0.01,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your contact no.';
                                  }
                                  //  if (EmailValidator.validate(value) == false) {
                                  //  return 'Invalid email';
                                  // }
                                  return null;
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_logintype);
                                },
                                onSaved: (newValue) {
                                  credentials['regContact'] = newValue;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.phone,
                                      color: Color(0xff373941),
                                    ),
                                    labelText: 'Contact',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xff373941),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    hintText: 'Enter contact No.',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Color(0xff373941))),
                                keyboardType: TextInputType.phone,
                                controller: _contact,
                              ),
                              SizedBox(
                                height: deviceHeight(context) * 0.01,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your contact no.';
                                  }
                                  //  if (EmailValidator.validate(value) == false) {
                                  //  return 'Invalid email';
                                  // }
                                  return null;
                                },
                                
                                onSaved: (newValue) {
                                  credentials['loginType'] = newValue;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.text_fields,
                                      color: Color(0xff373941),
                                    ),
                                    labelText: 'loginType',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xff373941),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    hintText: 'Enter logintype',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Color(0xff373941))),
                                keyboardType: TextInputType.text,
                                controller: _loginType,
                              ),
                              Container(
                                alignment: Alignment(1.0, 0.0),
                                // padding: EdgeInsets.only(top: 15.0, left: 20.0),
                                child: InkWell(
                                  onTap: () {
                                    // createAlertDialog(context);
                                    FocusScope.of(context).unfocus();
                                    Navigator.pushNamed(
                                        context, '/ForgotPassword');
                                  },
                                  child: Text(
                                    'Forgot Password ?',
                                    style: TextStyle(
                                      color: Color(0xff747474),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: deviceHeight(context) * 0.03,
                              ),
                              SizedBox(
                                height: deviceHeight(context) * 0.065,
                                width: deviceHeight(context) * 0.45,
                                child: ElevatedButton(
                                  //  color: Color(0xff3449C0),
                                  //textColor: Colors.white,
                                  //elevation: 2,
                                  // shape: RoundedRectangleBorder(
                                  // borderRadius: BorderRadius.circular(5.0),
                                  // ),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  onPressed: () {
                                    //  Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                                    loginParentUser();
                                  },
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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

  Future<void> loginParentUser() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    FocusScope.of(context).unfocus();
    setState(() {
      showLoadingSpinner();
    });
    try {
      String result = await Provider.of<DataProvider>(context, listen: false)
          .parentLogin(credentials['loginUserName'], credentials['loginPassword'],credentials['regContact'],credentials['inputType']);
      print('dsbvbsdjvbjsdb $result');
      if (result == 'success') {
       Fluttertoast.showToast(
        msg: "Login Successful",
      toastLength: Toast.LENGTH_LONG,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 1,
       backgroundColor: Colors.green[400],
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context);
        print(result);
        Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              children: [
                Icon(Icons.cancel, color: Colors.red),
                SingleChildScrollView(
                    child: Text(
                  'Login Failed',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF2D2F3B),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ))
              ],
            ),
            content: Text(
              'Incorrect Email or Password.',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFF2D2F3B),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'))
            ],
          ),
        );
      }
    } catch (error) {
      print('error occured while Login: $error');
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.cancel, color: Colors.red),
              SingleChildScrollView(
                  child: Text(
                'Login Failed',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF2D2F3B),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ))
            ],
          ),
          content: Text(
            'Something went wrong! Please be sure while entering email and password or try again later.',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFF2D2F3B),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('OK'))
          ],
        ),
      );
    }
  }
}
