import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ungfoodmall/screens/my_service.dart';
import 'package:ungfoodmall/screens/register.dart';
import 'package:http/http.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String user, password, name;

  // Method

  Widget showLogo() {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Ung Food Mall',
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.red[900],
        fontFamily: 'Vibes',
      ),
    );
  }

  Widget userText() {
    return Container(
      width: 200.0,
      child: TextFormField(
        decoration: InputDecoration(labelText: 'User :'),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Type User in the Blank';
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          user = value.trim();
        },
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: 200.0,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(labelText: 'Password :'),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Type Password in Blank';
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          password = value.trim();
        },
      ),
    );
  }

  Widget signInButton() {
    return RaisedButton(
      color: Colors.red[900],
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('user = $user, password = $password');
          checkAuthen();
        }
      },
    );
  }

  Future<void> checkAuthen() async {
    String urlAPI =
        'https://www.androidthai.in.th/sa/getUserWhereUserMaster.php?isAdd=true&User=$user';

    Response response = await get(urlAPI);
    var result = json.decode(response.body);
    print('result = $result');

    if (result.toString() == 'null') {
      myAlert('User False', 'No $user in my Database');
    } else {

      for (var map in result) {
        String turePassword = map['Password'];
        print('truePassword = $turePassword');
        name = map['Name'];

        if (password == turePassword) {
          
          MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => MyService(nameLogin: name,));                       
          Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);

        } else {
          myAlert('Password False', 'Try Again Password False');
        }

      }


    }
  }

  void myAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[okButton()],
          );
        });
  }

  Widget okButton() {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget signUpButton() {
    return OutlineButton(
      child: Text('Sign Up'),
      onPressed: () {
        print('You Click Sign Up');

        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        signInButton(),
        SizedBox(
          width: 4.0,
        ),
        signUpButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.white, Colors.yellow[600]],
              radius: 1.0,
            ),
          ),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  showLogo(),
                  showAppName(),
                  userText(),
                  passwordText(),
                  SizedBox(
                    height: 10.0,
                  ),
                  showButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
