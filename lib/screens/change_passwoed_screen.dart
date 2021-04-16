import 'package:email_validator/email_validator.dart';
import '../Providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/changePassword';
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  Map<String, String> credentials = {'Email': '', 'Password': ''};
  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(),
    );
  }

  Widget _buildPageContent() {
    return Container(
      height: deviceHeight(context),
      width: deviceHeight(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF2143FF), Color(0xff001381)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 40),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      'Forgot your password ?',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFFFE8B88)),
                    )),
                    SizedBox(
                      height: deviceHeight(context) * 0.02,
                    ),
                    Center(
                        child: Text(
                      'Confirm your email and we\'ll send the instructions.',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Color(0xFF2D2F3B)),
                    )),
                    SizedBox(
                      height: deviceHeight(context) * 0.02,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please input your Email';
                              }
                              //if (EmailValidator.validate(value) == false) {
                              //  return 'Invalid email';
                             // }
                              return null;
                            },
                            onSaved: (newValue) {
                              credentials['Email'] = newValue;
                            },
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
                            keyboardType: TextInputType.emailAddress,
                            controller: _email,
                          ),
                          SizedBox(height: deviceHeight(context) * 0.07),
                          SizedBox(
                            height: deviceHeight(context) * 0.065,
                            width: deviceWidth(context) * 0.79,
                            child: ElevatedButton(
                              // color: Color(0xff3449C0),
                              // textColor: Colors.white,
                              // elevation: 2,
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(5.0),
                              // ),
                              child: Text(
                                "Send Me Instructions",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              onPressed: () {
                                forgotPassword();
                              },
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight(context) * 0.07,
                          ),
                        ],
                      ),
                    ),
                  ],
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

  void forgotPassword() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      showLoadingSpinner();
      _formKey.currentState.save();
      try {
        Map<String, dynamic> responseData =
            await Provider.of<DataProvider>(context, listen: false)
                .forgotPassword(registeredEmail: credentials['Email']);
        if (responseData != null) {
          if (responseData['messageType'] == 'success') {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Row(
                  children: [
                    Icon(
                      Icons.done,
                      color: Colors.green,
                    ),
                    Text(
                      responseData['messageType'],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF2D2F3B),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                content: Text(
                  responseData['message'],
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF2D2F3B),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          } else {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Row(
                  children: [
                    Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),

        Text(
                      responseData['messageType'],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF2D2F3B),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
    ),
                  ],
                ),
                content: Text(
                  responseData['message'],
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF2D2F3B),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          }
        } else {
          Navigator.pop(context);
        }
      } catch (error) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text(
                  ' Failed',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF2D2F3B),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Text('Something went wrong!'),
            actions: [
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }
}
