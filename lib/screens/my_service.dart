import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyService extends StatefulWidget {
  final String nameLogin;
  MyService({Key key, this.nameLogin}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  String myNameLogin = '';
  List<String> names = [];
  List<String> prices = [];
  List<String> imageFoods = [];

  // Method
  @override
  void initState() {
    super.initState();
    setState(() {
      myNameLogin = widget.nameLogin;
    });
    readAllData();
  }

  Future<void> readAllData() async {
    String urlJSoN = 'https://www.androidthai.in.th/sa/getAllDataMaster.php';

    Response response = await get(urlJSoN);
    var result = json.decode(response.body);
    print('result = $result');
    for (var map in result) {
      setState(() {
        names.add(map['NameFood']);
        prices.add(map['Price']);
        imageFoods.add(map['ImagePath']);
      });
    }
  }

  Widget showNameLogin() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Menu Food'),
        Text(myNameLogin),
      ],
    );
  }

  Widget showImage(int index) {
    return Container(
      width: 200.0,
      height: 180.0,
      child: Image.network(imageFoods[index]),
    );
  }

  Widget showText(int index) {
    return Container(
      child: Column(
        children: <Widget>[Text(names[index]), Text(prices[index])],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: showNameLogin(),
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              showImage(index),
              showText(index),
            ],
          );
        },
      ),
    );
  }
}
