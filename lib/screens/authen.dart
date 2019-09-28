import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit

  // Method

  Widget showLogo() {
    return Container(
      width: 150.0,
      height: 150.0,
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
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: 200.0,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(labelText: 'Password :'),
      ),
    );
  }

  Widget signInButton() {
    return RaisedButton(color: Colors.red[900],
      child: Text('Sign In', style: TextStyle(color: Colors.white),),
      onPressed: () {},
    );
  }

  Widget signUpButton() {
    return OutlineButton(
      child: Text('Sign Up'),
      onPressed: () {},
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
              colors: [Colors.white, Colors.yellow[600]],radius: 1.0,
            ),
          ),
          child: Center(
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
    );
  }
}
