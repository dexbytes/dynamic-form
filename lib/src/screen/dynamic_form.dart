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
  List<String> fieldsForValidate = [];
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  DynamicFormState({required this.jsonEncoded}){
    responseParser.setFormData = jsonEncoded;
    autovalidateMode = _autoValidate();
  }

  //We will include the entered values in the map from field on submit click
  Map<String,dynamic> formSubmitData = <String,dynamic>{};
 
  Map<String,dynamic> autoValidateFieldList = <String,bool>{};
  final StreamController<bool> _fieldStreamControl = StreamController<bool>.broadcast();

  Stream get onAutoValidateChanged => _fieldStreamControl.stream;

  //Filter form field according type from json and return view
  Widget _getFormField({required Map<String,dynamic> data, Map<String,dynamic>? nextData}){

    String nextFieldKey = "";
    String currentElementKey = "";
    String currentElementType = "";
    bool isCurrentFieldRequired = false;

    if(data.containsKey("elementType") && data["elementType"].isNotEmpty)
    {
      currentElementType = data["elementType"].toString().toLowerCase();
      currentElementKey = data["elementConfig"]['name'];
    }
    if(data.containsKey("validation") && data["validation"] != null)
    {
      isCurrentFieldRequired = data["validation"]['required']??false;
    }

    if(nextData!=null && nextData.isNotEmpty && nextData.containsKey("elementType") && nextData["elementType"].isNotEmpty){
      String nextElementType = "";
      nextElementType = nextData["elementType"].toString().toLowerCase();
      if(nextElementType!=currentElementType){
        nextElementType = "";
      }
      else{
        nextFieldKey = nextData["elementConfig"]['name'];
      }
    }

    if(currentElementType.isNotEmpty){
      autoValidateFieldList[currentElementKey] = false;
      if (currentElementType != "input" && isCurrentFieldRequired) {
        fieldsForValidate.add(currentElementKey);
      }

      switch(currentElementType) {
        case "input":
          responseParser.setFieldFocusNode = currentElementKey;
          if (nextFieldKey.isNotEmpty) {
            responseParser.setFieldFocusNode = nextFieldKey;
          }
          //Open mobile field
          if (data.containsKey("elementConfig") &&
              data["elementConfig"].containsKey("type") &&
              data["elementConfig"]["type"].toString().toLowerCase() == "tel") {
            return TextFieldCountryPickerView(jsonData: data,
                onChangeValue: (String fieldKey, Map<String, String> value) {
                  formSubmitData[fieldKey] = value;
                },
                nextFieldKey: nextFieldKey);
          }
          return TextFieldView(
              jsonData: data, onChangeValue: (String fieldKey, String value) {
            formSubmitData[fieldKey] = value;
          }, nextFieldKey: nextFieldKey);

        case "select":
          return StreamBuilder(
              stream: onAutoValidateChanged,
              builder: (BuildContext context,
                  AsyncSnapshot<dynamic> snapshot) {
                return DropDown(jsonData: data,
                    autoValidate: snapshot.hasData,
                    onChangeValue: (String fieldKey, List<String> value) {
                      formSubmitData[fieldKey] = value;
                    });
              });

        case "radio":
            return StreamBuilder(
                stream: onAutoValidateChanged,
                builder: (BuildContext context,
                    AsyncSnapshot<dynamic> snapshot) {
                  return RadioButton(jsonData: data,
                      autoValidate: snapshot.hasData,
                      onChangeValue: (String fieldKey, String value) {
                        formSubmitData[fieldKey] = value;
                      });
                });

          case "checkbox":
          return StreamBuilder(
              stream: onAutoValidateChanged,
              builder: (BuildContext context,
                  AsyncSnapshot<dynamic> snapshot) {
                return CheckBoxWidget(jsonData: data,
                    autoValidate: snapshot.hasData,
                    onChangeValue: (String fieldKey, List<String> value){
            formSubmitData[fieldKey] = value;
          });  });

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
      if(fieldsForValidate.isNotEmpty){
        fieldsForValidate.map((e){
          if(formSubmitData.containsKey(e)){
            if(formSubmitData[e] == null || formSubmitData[e] == ''){
              setState(() {
                autoValidateFieldList[e] = true;
              });
              _fieldStreamControl.sink.add( autoValidateFieldList[e]);
            }
          }
        }).toList();
      }
      return AutovalidateMode.onUserInteraction;
    }
    return AutovalidateMode.disabled;

  }

  Widget formFieldList({required List<dynamic> formFieldList}){
    int nextItemIndex = 1;
    responseParser.clearFieldFocusNode();
    return Column(children: formFieldList.map((element) {
      Map<String,dynamic> data = element;
      Map<String,dynamic> nextData = {};

      if(nextItemIndex<formFieldList.length){
        nextData = formFieldList[nextItemIndex];
        nextItemIndex = nextItemIndex+1;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getFormField(data: data,nextData:nextData),
          const SizedBox(height: 20,width: 10)
        ],
      );
    }).toList());
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
                formFieldList(formFieldList:_formFieldList),
              ],
            ),
          ),
        )
        );
      },),
    );
  }
}

