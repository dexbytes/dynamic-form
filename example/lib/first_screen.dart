import 'package:dynamic_json_form/parts.dart';
import 'package:example/second_screen.dart';


class FirstScreen extends StatefulWidget {
 final String jsonString;
 final String apiCallingTime;
 const FirstScreen({Key? key,required this.jsonString,this.apiCallingTime = ""}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState(jsonString);
}

class _FirstScreenState extends State<FirstScreen> {
  final String jsonString;
  final _formKeyNew = GlobalKey<DynamicFormState>();

  _FirstScreenState(this.jsonString);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(centerTitle: true,title: Text('First Screen'),),
      body:
      Container(margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
        child: ListView(shrinkWrap: true,
          children: [
            Column(
              children: [
                //Get all fields of form
                DynamicForm(jsonString,dynamicFormKey: _formKeyNew,
                  finalSubmitCallBack: (Map<String, dynamic> data) async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondScreen(data: data)),
                  );

                },
                    currentStepCallBack:(int currentStepIndex,Map<String,dynamic> currentStepData){
  },submitButtonAlignment:Alignment.bottomCenter),

             /*   Row(children: [Align(alignment: Alignment.center,
                  child: ElevatedButton(clipBehavior: Clip.hardEdge,
                    onPressed: () async {
                      _formKeyNew.currentState!.previewStepCustomClick();
                    },
                    child: const Text('preview'),
                    //color: Colors.green,
                  ),
                ),
                  Align(alignment: Alignment.center,
                  child: ElevatedButton(clipBehavior: Clip.hardEdge,
                    onPressed: () async {
                      _formKeyNew.currentState!.nextStepCustomClick();
                    },
                    child: const Text('Submit Form'),
                    //color: Colors.green,
                  ),
                )],)*/
              ],
            ),
          ],
        ),
      ),

    );
  }
}
