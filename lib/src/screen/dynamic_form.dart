// ignore_for_file: no_logic_in_create_state
part of dynamic_json_form;

class DynamicForm extends StatefulWidget {
final String jsonEncoded;
final Function(Map<String,dynamic> data)? finalSubmitCallBack;
final GlobalKey<DynamicFormState>? dynamicFormKey ;
const DynamicForm(this.jsonEncoded,{this.dynamicFormKey,required this.finalSubmitCallBack}) : super(key: dynamicFormKey);

  @override
  DynamicFormState createState() => DynamicFormState(jsonEncoded: jsonEncoded);
}

class DynamicFormState extends State<DynamicForm> {
  String jsonEncoded;
  Stream get onVariableChanged => DataRefreshStream.instance.getFormFieldsStream.stream;
  List<dynamic> _formFieldList = [];
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  DynamicFormState({required this.jsonEncoded}){
    responseParser.setFormData = jsonEncoded;
    autovalidateMode = _autoValidate();
  }

  //We will include the entered values in the map from field on submit click
  Map<String,dynamic> formSubmitData = <String,dynamic>{};

  //Filter form field according type from json and return view
  Widget _getFormField({required Map<String,dynamic> data}){
    if(data.containsKey("elementType") && data["elementType"].isNotEmpty)
    {
      switch(data["elementType"]){
        case "input":
          //Open mobile field
          if(data.containsKey("elementConfig") && data["elementConfig"].containsKey("type") && data["elementConfig"]["type"].toString().toLowerCase() == "tel"){
            return TextFieldCountryPickerView(jsonData: data,onChangeValue: (String fieldKey, Map<String,String> value){
              formSubmitData[fieldKey] = value;
            });
          }
         return TextFieldView(jsonData: data,onChangeValue: (String fieldKey, String value){
        formSubmitData[fieldKey] = value;
         });

         case "select":
         return DropDown(jsonData: data,onChangeValue: (String fieldKey, List<String> value){
           formSubmitData[fieldKey] = value;
         });
      }
    }
    return Container();
  }


  //Check Form field value
  bool validateFields(){
    setState(() {
      autovalidateMode = _autoValidate(checkValidOnSubmit :true);
    });
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      //widget.finalSubmitCallBack?.call(formSubmitData);

      return true;
    }
    return false;
  }

  //Get form value
  Map<String,dynamic>?  getFormData(){
    setState(() {
      autovalidateMode = _autoValidate(checkValidOnSubmit :true);
    });
    if(_formKey.currentState!.validate()){
      return formSubmitData;
    }
    return null;
  }

  _autoValidate({bool checkValidOnSubmit = false}){
     /*if(checkValidOnChange){
      return AutovalidateMode.onUserInteraction;
    }
    else */
    if(checkValidOnSubmit) {
      return AutovalidateMode.onUserInteraction;
    }
    return AutovalidateMode.disabled;

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
        _formFieldList = responseParser.getFormData[responseParser.getCurrentFormNumber];
        return SizedBox(child:
        _formFieldList.isEmpty?Container():Form(
          key: _formKey,autovalidateMode: autovalidateMode,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(children: _formFieldList.map((element) {
                  Map<String,dynamic> data = element;
                  return Column(mainAxisSize: MainAxisSize.min,
                    children: [
                      _getFormField(data: data),
                      const SizedBox(height: 20,width: 10)
                    ],
                  );
                }).toList()),
                Align(alignment: Alignment.center,
                  child: ElevatedButton(clipBehavior: Clip.hardEdge,
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        widget.finalSubmitCallBack?.call(formSubmitData);
                      }
                    },
                    child: Text('Submit'),
                    //color: Colors.green,
                  ),
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

