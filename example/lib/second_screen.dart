import 'dart:convert';

import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
 final Map<String, dynamic> data;
 const SecondScreen({Key? key,required this.data}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState(data);
}

class _SecondScreenState extends State<SecondScreen> {
  final Map<String, dynamic> data;
String jsonEncoded = "";
  _SecondScreenState(this.data) {
    try {
      jsonEncoded = json.encode(data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(centerTitle: true,title: Text('Response details'),),
      body:
      Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
        child: Text(jsonEncoded),
      ),

    );
  }
}
