part of dynamic_json_form;
// enum formFieldType {text,name,email,tel,url,number,textMultiline}
class TextFieldView extends StatefulWidget {
  final Map<String,dynamic> jsonData;
  final TextFieldConfiguration? viewConfiguration;
  final Function (String fieldKey,String fieldValue) onChangeValue ;
   const TextFieldView({Key? key, required this.jsonData,required this.onChangeValue,this.viewConfiguration}) : super(key: key);
  @override
  _TextFieldsState createState() => _TextFieldsState(jsonData: jsonData,onChangeValue: onChangeValue,viewConfiguration: viewConfiguration);
}
class _TextFieldsState extends State<TextFieldView> {
  String fieldKey = "";
  bool obscureText = false;
  String formFieldType = "text";
  final _formFieldKey = GlobalKey<FormState>();
  Map<String,dynamic> jsonData;
  final TextEditingController? _nameController =  TextEditingController();
  TextFieldModel? textFieldModel;
  ConfigurationSetting configurationSetting = ConfigurationSetting.instance;
  TextFieldConfiguration? viewConfiguration;
  ViewConfig? viewConfig;
  Function (String fieldKey,String fieldValue) onChangeValue ;
  final StreamController<bool> _fieldStreamControl = StreamController<bool>();

  OverlayEntry? overlayEntry;
  Stream get onVariableChanged => _fieldStreamControl.stream;
  late FocusNode myFocusNode;
  bool checkValidOnChange = false;
  bool checkValid = true;
  bool checkValidOnSubmit = false;
  bool isDoneOver = false;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  _TextFieldsState({required this.jsonData,required this.onChangeValue,this.viewConfiguration}){
    textFieldModel ??= responseParser.textFormFiledParsing(jsonData: jsonData,updateCommon: true);

    if(textFieldModel!=null){
      _nameController!.text = textFieldModel!.value??"";

   if(textFieldModel!.elementConfig!=null){
        formFieldType = textFieldModel!.elementConfig!.type??"text";
        formFieldType  = formFieldType.toLowerCase();
        fieldKey = textFieldModel!.elementConfig!.name!;
        onChangeValue.call(fieldKey,"");
        checkValidOnChange = textFieldModel!.onchange??false;
        checkValid = textFieldModel!.valid??false;
        autovalidateMode = _autoValidate();

        viewConfig = ViewConfig(viewConfiguration: viewConfiguration,nameController: _nameController!,textFieldModel: textFieldModel!, formFieldType: formFieldType,obscureTextState: obscureText,obscureTextStateCallBack: (value){
          obscureText = value;
          _fieldStreamControl.sink.add(obscureText);
        });
      }
    }

  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      if (isDoneOver && (Platform.isIOS)) {
        bool hasFocus = myFocusNode.hasFocus;
        if (hasFocus)
          showOverlay(context);
        else
          removeOverlay();
      }
    });
   // _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController!.dispose();
    super.dispose();
  }

  //Get Keyboard type according to input type
  TextInputType keyBoardType({required String formFieldType}){
    TextInputType keyBoardType = TextInputType.text;
    switch(formFieldType){
        case 'text':
        keyBoardType = TextInputType.text;
        break ;
        case 'password':
        keyBoardType = TextInputType.text;
        obscureText = true;
        break ;
        case 'name':
        keyBoardType = TextInputType.name;
        break ;
        case 'email':
        keyBoardType = TextInputType.emailAddress;
        break ;
        case 'tel':
        isDoneOver = true;
        keyBoardType = TextInputType.phone;

        break ;
        case 'url':
        keyBoardType = TextInputType.url;
        break ;
        case 'number':
        isDoneOver = true;
        keyBoardType = TextInputType.number;
        break ;
        case 'text_multiline':
        isDoneOver = true;
        keyBoardType = TextInputType.multiline;
        break ;
    }
   // keyBoardType = TextInputType.text;

    return keyBoardType;
}

  List<TextInputFormatter>? inputFormatter(){
    String keyText = textFieldModel!.validation!.rejex!;
    List<TextInputFormatter>? filter = [];
    if(keyText.isNotEmpty){
      //filter = [];
     // filter.add(FilteringTextInputFormatter.allow(RegExp(keyText)));
      return filter;
    }
    return filter;
}

//Get minLine of input field
  int? minLine(){
    int minLine = textFieldModel!.elementConfig!.minLine!;
    //We are restrict input field must min 1 line not less not much in below case
    if(obscureText || configurationSetting.singleLineInputFields.contains(formFieldType.toLowerCase())){
      minLine = 1;
    }
    return minLine;
}

//Get maxLine of input field
  int? maxLine(){
    int maxLine = textFieldModel!.elementConfig!.maxLine!;
    //We are restrict input field must min 1 line not less not much in below case
    if(obscureText || configurationSetting.singleLineInputFields.contains(formFieldType.toLowerCase())){
      maxLine = 1;
    }
    return maxLine;
}


  Widget fieldHelpText(){
    if(textFieldModel!.help!=null && textFieldModel!.help!.text!.isNotEmpty){
      return Padding(
        padding: const EdgeInsets.only(top: 5.0,bottom: 5),
        child: Row(
          children: [
            Text(textFieldModel!.help!.text!,textAlign: TextAlign.left,),
          ],
        ),
      );
    }
    return Container();
}
  VerticalDirection fieldHelpPosition(){
    if(textFieldModel!.help!=null && textFieldModel!.help!.text!.isEmpty){
      return VerticalDirection.up;
    }
    return VerticalDirection.down;
  }

  //for ios done button callback
  onPressCallback() {
    removeOverlay();
    FocusScope.of(context).requestFocus(new FocusNode());
  }
  //for keyboard done button
  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context)!;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: InputDoneView(
            onPressCallback: onPressCallback,
            buttonName: "Done",
          ));
    });

    overlayState.insert(overlayEntry!);
  }
  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  _autoValidate({bool checkValidOnSubmit = false}){
    if(checkValidOnChange){
      return AutovalidateMode.onUserInteraction;
    }
    else if(checkValid ) {
      return AutovalidateMode.disabled;
    }
    return AutovalidateMode.disabled;

  }

  @override
  Widget build(BuildContext context) {

    //Check if data not pars properly
    if(fieldKey.isEmpty){
      return const SizedBox(height: 0,width: 0,);
    }

  /*  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _nameController!.text = textFieldModel!.value??"";
    });*/


    return Column(
      mainAxisSize: MainAxisSize.min,
      verticalDirection: fieldHelpPosition(),
      children: [
      StreamBuilder(
      stream: onVariableChanged,builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          obscureText = snapshot.data;
        }
        return TextFormField(
        key: _formFieldKey,focusNode: myFocusNode,strutStyle:StrutStyle(),
        readOnly: textFieldModel!.validation!.isReadOnly!,
        enabled: !textFieldModel!.validation!.isDisabled!,
        controller: _nameController,
        textInputAction: TextInputAction.done,
        maxLength: textFieldModel!.validation!.maxLength,   //It is the length of char
        maxLines: maxLine(),
        minLines: minLine(),
        decoration: viewConfig!.getInputDecoration(),obscureText: obscureText,
        keyboardType: keyBoardType(formFieldType: formFieldType),
        inputFormatters: inputFormatter(),
        validator: (value){
    if(value!.isEmpty && !checkValid){
      return null;
    }
    else if(value.isNotEmpty && !checkValid && !checkValidOnChange){
      return null;
    }
          return commonValidation.checkValidation(enteredValue:value,validationStr: textFieldModel!.validationStr!,formFieldType:formFieldType);
          /*//Check all validation on change
          if(checkValid && checkValidOnChange){
            return commonValidation.checkValidation(enteredValue:value!,validationStr: textFieldModel!.validationStr!,formFieldType:formFieldType);
          }
          //Check all validation on submit
          else if(checkValidOnSubmit && !checkValidOnChange && checkValid){
            return commonValidation.checkValidation(enteredValue:value!,validationStr: textFieldModel!.validationStr!,formFieldType:formFieldType);
          }
          //Check validation on submit and will not submit data on server
          else if(value!.isNotEmpty && checkValidOnSubmit && !checkValidOnChange && !checkValid){
            return commonValidation.checkValidation(enteredValue:value,validationStr: textFieldModel!.validationStr!,formFieldType:formFieldType);
          }
          else if(value.isNotEmpty && checkValidOnSubmit){
            return commonValidation.checkValidation(enteredValue:value,validationStr: textFieldModel!.validationStr!,formFieldType:formFieldType);
          }
        return null;*/
        }
      ,onChanged: (value){
            if(mounted){
              onChangeValue.call(fieldKey,value);
            }
        },
          onSaved: (value){
            //Check all validation on submit
            /*if((!checkValidOnChange && checkValid)){
              setState(() {
                checkValidOnSubmit = true;
              });
              _formFieldKey.currentState!.validate();
            }*/
            //Check validation on submit and will not submit data on server
             if((value!.isNotEmpty && checkValid)){
              /*setState(() {
                checkValidOnSubmit = true;
                autovalidateMode = _autoValidate(checkValidOnSubmit : true);
              });*/
             // _formFieldKey.currentState!.validate();
            }
             else if((checkValid)){
              /*setState(() {
                checkValidOnSubmit = true;
                autovalidateMode = _autoValidate(checkValidOnSubmit : true);
              });*/

             // _formFieldKey.currentState!.validate();
            }
            //Check validation on submit and will not submit data on server
            /*else if((value.isNotEmpty && !checkValidOnChange && !checkValid)){
              setState(() {
                checkValidOnSubmit = true;
              });
              _formFieldKey.currentState!.validate();
            }*/

          },
          autovalidateMode: autovalidateMode,
        );
  },),
        fieldHelpText(),

      ],
    );
  }
}
class ViewConfig{
  TextFieldConfiguration? viewConfiguration;
  String formFieldType;
  TextFieldModel textFieldModel;
  TextEditingController nameController;
  bool? obscureTextState;
  Function(bool)? obscureTextStateCallBack;
  ViewConfig({required this.nameController,required this.formFieldType,required this.textFieldModel,this.obscureTextState = true,this.obscureTextStateCallBack,this.viewConfiguration}) {
  viewConfiguration  = viewConfiguration ?? ConfigurationSetting.instance._textFieldConfiguration;
  }

  InputDecoration _getTextDecoration (){
 return InputDecoration(
        border: viewConfiguration!._border,
     /*   errorBorder: viewConfiguration!._errorBorder,
        focusedErrorBorder: viewConfiguration!._errorBorder,*/
        enabledBorder: viewConfiguration!._border,
        hintText: textFieldModel.elementConfig!.placeholder??"",hintStyle: viewConfiguration!._hintStyle,
        label: textFieldModel.elementConfig!.label !=null && textFieldModel.elementConfig!.label!.isNotEmpty?Text(textFieldModel.elementConfig!.label!,style: viewConfiguration!._textStyle,):null,suffixIcon: null,counterText: ""
    );

  }

  getInputDecoration(){
    InputDecoration inputDecoration = _getTextDecoration();
    Widget? suffixIcon;
    if(textFieldModel.elementConfig!=null){
      if(textFieldModel.elementConfig!.resetIcon!){
        suffixIcon = SuffixCloseIcon(textController: nameController,iconClicked: (){
          nameController.text = "";
        },);
      }
    }
    inputDecoration =  inputDecoration.copyWith(suffixIcon: suffixIcon);

    switch(formFieldType){
      case 'text':
        inputDecoration =  inputDecoration.copyWith(suffixIcon: suffixIcon);
      break ;
      case 'password':{
        inputDecoration =  inputDecoration.copyWith(suffixIcon: textFieldModel.elementConfig!.resetIcon!?SuffixVisibilityIcon(initialValue: obscureTextState,iconClicked: (bool visibleStatus){
          try {
            obscureTextStateCallBack?.call(visibleStatus);
          } catch (e) {
            print(e);
          }
        },):null);
      }
        break ;
      case 'name':
        inputDecoration =  inputDecoration.copyWith(suffixIcon: suffixIcon);
        break ;
      case 'email':
        inputDecoration =  inputDecoration.copyWith(suffixIcon: suffixIcon);
        break ;
      case 'tel':
        inputDecoration =  inputDecoration.copyWith(suffixIcon: suffixIcon);
        break ;
      case 'url':
        inputDecoration =  inputDecoration.copyWith(suffixIcon: suffixIcon);
        break ;
      case 'number':
        inputDecoration =  inputDecoration.copyWith(suffixIcon: suffixIcon);
        break ;
      case 'text_multiline':
        inputDecoration =  inputDecoration.copyWith(suffixIcon: suffixIcon);
        break ;
    }

    return inputDecoration;
  }
}
class ActionConfig{

}

