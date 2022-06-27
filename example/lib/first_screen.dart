import 'dart:convert';

import 'package:dynamic_json_form/parts.dart';
import 'package:example/second_screen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
 final String jsonString;
 final String apiCallingTime;
 const FirstScreen({Key? key,required this.jsonString,this.apiCallingTime = ""}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState(jsonString);
}

class _FirstScreenState extends State<FirstScreen> {
  final String jsonString;
  _FirstScreenState(this.jsonString) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(centerTitle: true,title: Text('First Screen'),),
      body:
      Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
        child: ListView(
          children: [
            Column(
              children: [
                Text(widget.apiCallingTime),
                DynamicForm(jsonString, finalSubmitCallBack: (Map<String, dynamic> data) async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondScreen(data: data)),
                  );
                },),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
