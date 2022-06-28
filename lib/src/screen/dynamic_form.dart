// ignore_for_file: no_logic_in_create_state
part of dynamic_json_form;

class DynamicForm extends StatefulWidget {
final String jsonEncoded;
final Function(Map<String,dynamic> data)? finalSubmitCallBack;

const DynamicForm(this.jsonEncoded,{Key? key,required this.finalSubmitCallBack}) : super(key: key);

  @override
  _DynamicFormState createState() => _DynamicFormState(jsonEncoded: jsonEncoded);
}

class _DynamicFormState extends State<DynamicForm> {
  String jsonEncoded;
  Stream get onVariableChanged => DataRefreshStream.instance.getFormFieldsStream.stream;
  List<dynamic> formFieldList = [];
  final _formKey = GlobalKey<FormState>();

  _DynamicFormState({required this.jsonEncoded}){
    responseParser.setFormData = jsonEncoded;
  }

  //We will include the entered values in the map from field on submit click
  Map<String,dynamic> formSubmitData = <String,dynamic>{};

  //Filter form field according type from json and return view
  Widget _getFormField({required Map<String,dynamic> data}){
    if(data.containsKey("elementType") && data["elementType"].isNotEmpty)
    {
      switch(data["elementType"]){
        case "input":
         return TextFieldView(jsonData: data,onChangeValue: (String fieldKey, String value){
           formSubmitData[fieldKey] = value;
         });

      }
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      child: !commonValidation.isValidJsonEncoded(jsonEncoded)?Container():StreamBuilder(
        stream: onVariableChanged,builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        /*if (snapshot.connectionState == ConnectionState.waiting) {
          //commonValidation.setFormData = jsonEncoded;
          return const Center(
            child: Text(""),
          );
        }
        else{
         // commonValidation.setFormData = jsonEncoded;
        }*/
        /*if(snapshot.hasData){
          formFieldList = snapshot.data;
        }*/
        formFieldList = responseParser.getFormData[responseParser.getCurrentFormNumber];
        return SizedBox(child:
        formFieldList.isEmpty?Container():Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(children: formFieldList.map((element) {
                  Map<String,dynamic> data = element;
                  return Column(mainAxisSize: MainAxisSize.min,
                    children: [
                      _getFormField(data: data),
                      const SizedBox(height: 20,width: 10)
                    ],
                  );
                }).toList()),
                FlatButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      widget.finalSubmitCallBack?.call(formSubmitData);
                    }
                  },
                  child: Text('Submit'),
                  color: Colors.green,
                ),
              ],
            ),
          ),
        )
        );
      },),
    );
  }
}

