import 'package:dynamic_json_form/dynamic_json_form.dart';
import 'package:example/http_service.dart';
import 'package:example/second_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  // if you are using await in main function then add this line
  WidgetsFlutterBinding.ensureInitialized();

  print("****** Start local jason from assets *** ${DateTime.now().millisecondsSinceEpoch}");
  // String jsonStringResponse = await httpService.getPosts();
  String jsonString = "";//jsonStringResponse;

  if(jsonString.isEmpty) {
    jsonString = await localJsonRw.localRead();
  }
  print("****** End local jason from assets ********* ${DateTime.now().millisecondsSinceEpoch}");
  runApp(MyApp(jsonString));
}

class MyApp extends StatelessWidget {

  String jsonString = "";
  MyApp(this.jsonString);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic TextFormFields',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyForm(jsonString),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyForm extends StatefulWidget {
  String jsonString = "";
  MyForm(this.jsonString);
  @override
  _MyFormState createState() => _MyFormState(jsonString);
}

class _MyFormState extends State<MyForm> {
  String jsonString = "";
  _MyFormState(this.jsonString){
    print("$jsonString");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(centerTitle: true,title: Text('Dynamic TextFormFields'),),
      body:
      DynamicForm(jsonString, finalSubmitCallBack: (Map<String, dynamic> data) async {},),

    );
  }




}


