import 'package:dynamic_json_form/dynamic_json_form.dart';
import 'package:example/first_screen.dart';
import 'package:example/http_service.dart';
import 'package:example/time_duration.dart';
import 'package:flutter/material.dart';

void main() async {
  // if you are using await in main function then add this line
  WidgetsFlutterBinding.ensureInitialized();
  ConfigurationSetting.instance.textField();
  ConfigurationSetting.instance.setLoadFromApi = true;

  String? jsonString = await ConfigurationSetting.instance.getFormDataLocal();
  if(jsonString!.isEmpty) {
    String jsonStringResponse = await httpService.getPosts();
    jsonString = await ConfigurationSetting.instance.storeFormDataLocal(jsonStringResponse);
  }

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
  bool isLoading = false;

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
      appBar: AppBar(centerTitle: true,title: const Text('Dynamic TextFormFields'),),
      body: Center(
        child: Stack(alignment: Alignment.center,
          children: [
            isLoading?Container():
            SizedBox(child:
            Column(mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(child: Text(!ConfigurationSetting.instance.getLoadFromApi?"Switch to always from API":"Switch to always from local"),
                  onPressed: () async {
                  setState(() {
                    ConfigurationSetting.instance.setLoadFromApi = !ConfigurationSetting.instance.getLoadFromApi;
                  });
                },),
                SizedBox(height: 20,),
                OutlinedButton(child: const Text("Get Data"),
                  onPressed: () async {
                    timeDuration.startTimeDuration();
                  setState(() {
                    isLoading = true;
                  });
                    String? jsonString = await ConfigurationSetting.instance.getFormDataLocal();
                    if(jsonString!.isEmpty) {
                      String jsonStringResponse = await httpService.getPosts();

                      // String jsonStringResponse = await localJsonRw.localRead();
                      jsonString = await ConfigurationSetting.instance.storeFormDataLocal(jsonStringResponse);
                    }
                  setState(() {
                    isLoading = false;
                  });
                    String time = timeDuration.endTime(message:"Api calling",reset: true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FirstScreen(jsonString: jsonString!,apiCallingTime: time,)),
                    );
                },),
              ],
            ),),
            isLoading?const SizedBox(height: 50,width: 50,child: CircularProgressIndicator()):Container()
          ],
        ),
      )
      /*DynamicForm(jsonString, finalSubmitCallBack: (Map<String, dynamic> data) async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FirstScreen(jsonString: jsonString)),
        );
      },)*/,

    );
  }




}


