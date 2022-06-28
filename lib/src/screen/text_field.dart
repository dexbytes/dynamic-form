part of dynamic_json_form;

// enum formFieldType {text,name,email,tel,url,number,textMultiline}

class TextFieldView extends StatefulWidget {
  final Map<String,dynamic> jsonData;
  final Function (String fieldKey,String fieldValue) onChangeValue ;
   const TextFieldView({Key? key, required this.jsonData,required this.onChangeValue}) : super(key: key);
  @override
  _TextFieldsState createState() => _TextFieldsState(jsonData: jsonData);
}

class _TextFieldsState extends State<TextFieldView> {
  String fieldKey = "";
  bool obscureText = true;
  String formFieldType = "text";
  final _formFieldKey = GlobalKey<FormState>();
  Map<String,dynamic> jsonData;
  final TextEditingController? _nameController =  TextEditingController();
  TextFieldModel? textFieldModel;
  ConfigurationSetting configurationSetting = ConfigurationSetting.instance;
  ViewConfig? viewConfig;

  final StreamController<bool> _fieldStreamControl = StreamController<bool>();
  Stream get onVariableChanged => _fieldStreamControl.stream;

  _TextFieldsState({required this.jsonData}){
    obscureText = true;
    textFieldModel ??= responseParser.textFormFiledParsing(jsonData: jsonData,updateCommon: true);

    if(textFieldModel!=null && textFieldModel!.elementConfig!=null){
      formFieldType = /*textFieldModel!.elementConfig!.type??*/"password";
      formFieldType  = formFieldType.toLowerCase();
      fieldKey = textFieldModel!.elementConfig!.name!;

      viewConfig = ViewConfig(nameController: _nameController!,textFieldModel: textFieldModel!, formFieldType: formFieldType,obscureTextState: obscureText,obscureTextStateCallBack: (value){
        //setState(() {
          obscureText = value;
          _fieldStreamControl.sink.add(obscureText);
       // });
      });
    }
  }

  @override
  void initState() {
    super.initState();
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
        break ;
        case 'name':
        keyBoardType = TextInputType.name;
        break ;
        case 'email':
        keyBoardType = TextInputType.emailAddress;
        break ;
        case 'tel':
        keyBoardType = TextInputType.phone;
        break ;
        case 'url':
        keyBoardType = TextInputType.url;
        break ;
        case 'number':
        keyBoardType = TextInputType.number;
        break ;
        case 'text_multiline':
        keyBoardType = TextInputType.multiline;
        break ;
    }
   // keyBoardType = TextInputType.text;

    return keyBoardType;
}

  List<TextInputFormatter> inputFormatter(){
    String keyText = r'(^[a-zA-Z ]*$)';//textFieldModel!.validation!.rejex!;
    List<TextInputFormatter> filter = [];
    if(keyText.isNotEmpty){
      filter.add(FilteringTextInputFormatter.allow(RegExp(keyText)));
      return filter;
    }
    return filter;
}


  Widget fieldHelpText(){
    if(textFieldModel!.help!.text!.isNotEmpty){
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
    if(textFieldModel!.help!.text!.isEmpty){
      return VerticalDirection.up;
    }
    return VerticalDirection.down;
  }

  /*getInputDecoration(){
    InputDecoration inputDecoration = getTextDecoration(textFieldModel: textFieldModel);

    //Add Click event on suffixIcon if suffixIcon added
    if(inputDecoration.suffixIcon!=null){

      inputDecoration =  inputDecoration.copyWith(suffixIcon: SuffixCloseIcon(textController: _nameController,iconClicked: (){
        _nameController!.text = "";
        debugPrint("");
      },));
    }

    return inputDecoration;
  }*/


  /*InputDecoration getTextDecoration ({TextFieldModel? textFieldModel}){
      Widget? suffixIcon;
      if(textFieldModel!=null){
        if(textFieldModel.elementConfig!.resetIcon!){
          suffixIcon = const SuffixCloseIcon();
        }
      }
      return InputDecoration(
          border: configurationSetting._textFieldConfiguration.border,
          enabledBorder: configurationSetting._textFieldConfiguration.border,
          hintText: textFieldModel?.elementConfig!.placeholder??"",hintStyle: configurationSetting._textFieldConfiguration.hintStyle,
          label: textFieldModel?.elementConfig!.label !=null && textFieldModel!.elementConfig!.label!.isNotEmpty?Text(textFieldModel.elementConfig!.label!,style: configurationSetting._textFieldConfiguration.textStyle,):null,suffixIcon: suffixIcon,counterText: ""
      );

  }*/

  @override
  Widget build(BuildContext context) {

    //Check if data not pars properly
    if(fieldKey.isEmpty){
      return const SizedBox(height: 0,width: 0,);
    }

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _nameController!.text = textFieldModel!.value??"";
    });


    return Column(
      mainAxisSize: MainAxisSize.min,
      verticalDirection: fieldHelpPosition(),
      children: [
      StreamBuilder(
      stream: onVariableChanged,builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          obscureText = snapshot.data;
        }
        return TextFormField(key: _formFieldKey,
        readOnly: textFieldModel!.validation!.isReadOnly!,
        enabled: !textFieldModel!.validation!.isDisabled!,
        controller: _nameController,
        textInputAction: TextInputAction.done,
        maxLength: textFieldModel!.validation!.maxLength,   //It is the length of char
        maxLines: 1//textFieldModel!.validation!.maxLength,   // it related to input field line
        ,minLines: 1//textFieldModel!.validation!.minLength,  // it related to input field line
        //onChanged: (v) => _MyFormState.friendsList![widget.index] = v,
        ,
        decoration: viewConfig!.getInputDecoration(),obscureText: obscureText,
        keyboardType: keyBoardType(formFieldType: formFieldType),
        inputFormatters: inputFormatter(),
        validator: (value){
        if(textFieldModel!.valid! && textFieldModel!.validation!.required!){
        return commonValidation.checkValidation(enteredValue:value!,validationStr: textFieldModel!.validationStr!,formFieldType:formFieldType);
        }
        return null;
        }
      ,onChanged: (value){
            if(mounted){
              widget.onChangeValue.call(fieldKey,value);
            }
        },
          onSaved: (value){
           /* f1.unfocus();
            FocusScope.of(context).requestFocus(f2);*/
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        );
  },),
        fieldHelpText(),

      ],
    );
  }
}

class ViewConfig{
  ConfigurationSetting configurationSetting = ConfigurationSetting.instance;
  String formFieldType;
  TextFieldModel textFieldModel;
  TextEditingController nameController;
  bool? obscureTextState;
  Function(bool)? obscureTextStateCallBack;
  ViewConfig({required this.nameController,required this.formFieldType,required this.textFieldModel,this.obscureTextState = true,this.obscureTextStateCallBack});

  InputDecoration _getTextDecoration (){
    Widget? suffixIcon;
    if(textFieldModel.elementConfig!=null){
      if(textFieldModel.elementConfig!.resetIcon!){
        suffixIcon = const SuffixCloseIcon();
      }
    }
    return InputDecoration(
        border: configurationSetting._textFieldConfiguration.border,
        enabledBorder: configurationSetting._textFieldConfiguration.border,
        hintText: textFieldModel.elementConfig!.placeholder??"",hintStyle: configurationSetting._textFieldConfiguration.hintStyle,
        label: textFieldModel.elementConfig!.label !=null && textFieldModel.elementConfig!.label!.isNotEmpty?Text(textFieldModel.elementConfig!.label!,style: configurationSetting._textFieldConfiguration.textStyle,):null,suffixIcon: suffixIcon,counterText: ""
    );

  }

  getInputDecoration(){
    InputDecoration inputDecoration = _getTextDecoration();

    switch(formFieldType){
      case 'text':
      //Add Click event on suffixIcon if suffixIcon added
        inputDecoration =  inputDecoration.copyWith(suffixIcon: inputDecoration.suffixIcon??SuffixCloseIcon(textController: nameController,iconClicked: (){
          nameController.text = "";
        },));
        break ;
      case 'password':{
        inputDecoration =  inputDecoration.copyWith(suffixIcon: inputDecoration.suffixIcon??SuffixVisibilityIcon(initialValue: obscureTextState,iconClicked: (bool visibleStatus){
          try {
            obscureTextStateCallBack?.call(visibleStatus);
          } catch (e) {
            print(e);
          }
        },));
      }
        break ;
      case 'name':
      //Add Click event on suffixIcon if suffixIcon added
        inputDecoration =  inputDecoration.copyWith(suffixIcon: inputDecoration.suffixIcon??SuffixCloseIcon(textController: nameController,iconClicked: (){
          nameController.text = "";
        },));
        break ;
      case 'email':
      //Add Click event on suffixIcon if suffixIcon added
        inputDecoration =  inputDecoration.copyWith(suffixIcon: inputDecoration.suffixIcon??SuffixCloseIcon(textController: nameController,iconClicked: (){
          nameController.text = "";
        },));
        break ;
      case 'tel':
      //Add Click event on suffixIcon if suffixIcon added
        inputDecoration =  inputDecoration.copyWith(suffixIcon: inputDecoration.suffixIcon??SuffixCloseIcon(textController: nameController,iconClicked: (){
          nameController.text = "";
        },));
        break ;
      case 'url':
      //Add Click event on suffixIcon if suffixIcon added
        inputDecoration =  inputDecoration.copyWith(suffixIcon: inputDecoration.suffixIcon??SuffixCloseIcon(textController: nameController,iconClicked: (){
          nameController.text = "";
        },));
        break ;
      case 'number':
      //Add Click event on suffixIcon if suffixIcon added
        inputDecoration =  inputDecoration.copyWith(suffixIcon: inputDecoration.suffixIcon??SuffixCloseIcon(textController: nameController,iconClicked: (){
          nameController.text = "";
        },));
        break ;
      case 'text_multiline':
        break ;
    }

    return inputDecoration;
  }
}
class ActionConfig{

}

