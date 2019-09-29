import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String name, user, password;

  // Method
  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('name = $name, user = $user, password = $password');
          registerThread();
        }
      },
    );
  }

  Future<void> registerThread()async{

    String urlAPI = 'https://www.androidthai.in.th/sa/addDataMaster.php?isAdd=true&Name=$name&User=$user&Password=$password';

    var response = await http.get(urlAPI);
    var result = json.decode(response.body);
    print('result = $result');

    if (result.toString() == 'true') {
      Navigator.of(context).pop();
    }


  }

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.fingerprint,
          size: 36.0,
        ),
        labelText: 'Display Name :',
        helperText: 'Type Your Name',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Name in the Blank';
        } else {
          return null;
        }
      },onSaved: (String value){
        name = value.trim();
      },
    );
  }

  Widget userText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.account_box,
          size: 36.0,
        ),
        labelText: 'User :',
        helperText: 'Type Your User',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'กรุณา กรอก User ด้วย คะ';
        } else {
          return null;
        }
      },onSaved: (String value){
        user = value.trim();
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          size: 36.0,
        ),
        labelText: 'Password :',
        helperText: 'Type Your Password',
      ),
      validator: (String value) {
        if (value.length < 6) {
          return 'Password More 6 Charactor';
        } else {
          return null;
        }
      },onSaved: (String value){
        password = value.trim();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        title: Text('Regisger'),
        actions: <Widget>[registerButton()],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(50.0),
          children: <Widget>[
            nameText(),
            userText(),
            passwordText(),
          ],
        ),
      ),
    );
  }
}
