part of dynamic_json_form;

class DynamicForm extends StatefulWidget {
final String jsonEncoded;
final Function(Map<String,dynamic> data)? finalSubmitCallBack;
final Function(int,Map<String,dynamic>)? currentStepCallBack;
final GlobalKey<DynamicFormState>? dynamicFormKey ;


const DynamicForm(this.jsonEncoded,{this.dynamicFormKey,required this.finalSubmitCallBack,this.currentStepCallBack}) : super(key: dynamicFormKey);
  @override
  DynamicFormState createState() => DynamicFormState(jsonEncoded: jsonEncoded);
}

class DynamicFormState extends State<DynamicForm> {
  String jsonEncoded;
  Stream get onVariableChanged => DataRefreshStream.instance.getFormFieldsStream.stream;
  Map<String,dynamic> formSubmitData = <String,dynamic>{};
  Map<int,List<dynamic>> formScreenList = {};
  Map<int,Widget> formScreen = {};

  DynamicFormState({required this.jsonEncoded}){
    responseParser.setFormData = jsonEncoded;
    formScreenList = responseParser.getFormData;
/* formScreen[0] = SingleForm(formFieldList:formScreenList[0]!,nextPageButtonClick:(index){
     // print("$index == $currentIndex");
      formScreen[0] = formScreen[0]!;
      setState(() {
      });
    });
    formScreen[1] = SingleForm(formFieldList:formScreenList[1]!,nextPageButtonClick:(index){
     // print("$index == $currentIndex");
      setState(() {
      });
    });*/
  }
  SingleForm? singleForm;
  void nextStepCustomClick(){
    /*if (responseParser.getTotalFormsCount-1 >
        responseParser.getCurrentFormNumber) {
      if (validateFields()) {
        var data = getFormData();
        if (data!.isNotEmpty) {
          setState(() {
            responseParser.setCurrentFormNumber =
                responseParser.getCurrentFormNumber +
                    1;
          });
        }
      }
      widget.nextPageButtonClick?.call(
          responseParser.getCurrentFormNumber,formSubmitData);
      print(">>Submit 2 >> ${responseParser
          .getCurrentFormNumber}");
    }
    else {
      if (validateFields()) {
        var data = getFormData();
        if (data!.isNotEmpty) {
          widget.finalSubmitCallBack?.call(responseParser.getCurrentFormNumber,formSubmitData);
        }
      }
    }*/
  }
  void previewStepCustomClick(){
    if (responseParser.getCurrentFormNumber > 0) {
      print(">>Pre 2 >> ${responseParser
          .getCurrentFormNumber}");
      setState(() {
        responseParser.setCurrentFormNumber =
            responseParser.getCurrentFormNumber - 1;
      });
      print(">>Pre 3 >> ${responseParser
          .getCurrentFormNumber}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: !commonValidation.isValidJsonEncoded(jsonEncoded)?Container():
      Column(mainAxisSize: MainAxisSize.min,children: [
      ListView.builder(shrinkWrap: true,physics: const ClampingScrollPhysics(),
          itemCount: formScreenList.length,
          itemBuilder: (BuildContext context, int index) {
            if(responseParser.getCurrentFormNumber!=index){
              return const SizedBox(height: 0,);
            }
            List<dynamic> _formFieldList =  formScreenList[index]!;
            final currentIndex = index;
            return SingleForm(formFieldList:_formFieldList,
              nextPageButtonClick:(index,Map<String,dynamic> formSubmitData){
              this.formSubmitData ['$currentIndex'] = formSubmitData;
              widget.currentStepCallBack?.call(currentIndex,formSubmitData);
              print("$index == $currentIndex");
              setState(() {
              });
            },
              finalSubmitCallBack:(index,Map<String,dynamic> formSubmitData){
              this.formSubmitData ['$currentIndex'] = formSubmitData;
              widget.finalSubmitCallBack?.call(this.formSubmitData);
              print("$index == $currentIndex");
            },index: index,);
          })],)
    );
  }
}



