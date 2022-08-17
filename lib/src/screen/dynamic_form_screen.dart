part of dynamic_form;

class DynamicFormScreen extends StatefulWidget {
final String jsonEncoded;
final Function(Map<String,dynamic> data)? finalSubmitCallBack;
final GlobalKey<DynamicFormScreenState>? dynamicFormKey ;
const DynamicFormScreen(this.jsonEncoded,{this.dynamicFormKey,required this.finalSubmitCallBack}) : super(key: dynamicFormKey);
  @override
  DynamicFormScreenState createState() => DynamicFormScreenState(jsonEncoded: jsonEncoded);
}

class DynamicFormScreenState extends State<DynamicFormScreen> {
  String jsonEncoded;
  Stream get onVariableChanged => DataRefreshStream.instance.getFormFieldsStream.stream;
  List<dynamic> _formFieldList = [];
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  DynamicFormScreenState({required this.jsonEncoded}){
    responseParser.setFormData = jsonEncoded;
    autovalidateMode = _autoValidate();
  }

  //We will include the entered values in the map from field on submit click
  Map<String,dynamic> formSubmitData = <String,dynamic>{};

  //Filter form field according type from json and return view
  Widget _getFormField({required Map<String,dynamic> data, Map<String,dynamic>? nextData}){

    String nextFieldKey = "";
    String currentElementKey = "";
    String currentElementType = "";
    String? _singleValue = "Text alignment right";
    String _verticalGroupValue = "Pending";

    List<String> _status = ["Pending", "Released", "Blocked"];

    if(data.containsKey("elementType") && data["elementType"].isNotEmpty)
    {
      currentElementType = data["elementType"].toString().toLowerCase();
      currentElementKey = data["elementConfig"]['name'];
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
      switch(currentElementType){
        case "input":
          responseParser.setFieldFocusNode = currentElementKey;
          if(nextFieldKey.isNotEmpty){
            responseParser.setFieldFocusNode = nextFieldKey;
          }
          //Open mobile field
          if(data.containsKey("elementConfig") && data["elementConfig"].containsKey("type") && data["elementConfig"]["type"].toString().toLowerCase() == "tel"){
            return TextFieldCountryPickerView(jsonData: data,onChangeValue: (String fieldKey, Map<String,String> value){
              formSubmitData[fieldKey] = value;
            },nextFieldKey: nextFieldKey);
          }
          return TextFieldView(jsonData: data,onChangeValue: (String fieldKey, String value){
            formSubmitData[fieldKey] = value;
          },nextFieldKey: nextFieldKey);

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
      return Column(mainAxisSize: MainAxisSize.min,
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

