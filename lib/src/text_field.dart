part of dynamic_json_form;

class TextFieldView extends StatefulWidget {
  final Map<String,dynamic> jsonData;
  final Function (String fieldKey,String fieldValue) onChangeValue ;
   const TextFieldView({Key? key, required this.jsonData,required this.onChangeValue}) : super(key: key);
  @override
  _TextFieldsState createState() => _TextFieldsState(jsonData: jsonData);
}

class _TextFieldsState extends State<TextFieldView> {
  String fieldKey = "";
  Map<String,dynamic> jsonData;
  TextEditingController? _nameController;
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  TextFieldModel? textFieldModel;
  ConfigurationSetting configurationSetting = ConfigurationSetting.instance;
  _TextFieldsState({required this.jsonData}){
    textFieldModel ??= responseParser.textFormFiledParsing(jsonData: jsonData,updateCommon: true);

    if(textFieldModel!=null){
      fieldKey = textFieldModel!.elementConfig!.name!;
    }
    f1 = FocusNode(debugLabel: textFieldModel!.elementConfig!.name!);

    f2 = FocusNode(debugLabel: "first_name");

  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController!.dispose();
    super.dispose();
  }

  TextInputType keyBoardType(){
    TextInputType keyBoardType = TextInputType.text;
    String keyText = textFieldModel!.elementConfig!.type!.toLowerCase();
    switch(keyText){
      case 'text':
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
   // keyBoardType = TextInputType.emailAddress;

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

  getInputDecoration(){
    InputDecoration inputDecoration = getTextDecoration(textFieldModel: textFieldModel);

    //Add Click event on suffixIcon if suffixIcon added
    if(inputDecoration.suffixIcon!=null){

      inputDecoration =  inputDecoration.copyWith(suffixIcon: SuffixIconTextFiled(textController: _nameController,iconClicked: (){
        _nameController!.text = "";
        debugPrint("");
      },));
    }

    return inputDecoration;
  }

 String? checkValidation(Validation validation,String value){
    String? errorMsg = validation.errorMessage!.required!;
    try {
      if(value.trim().isEmpty){
            return errorMsg;
          }
      if(value.length > validation.maxLength!){
            errorMsg = validation.errorMessage!.maxLength!;
          }
          else if(value.length < validation.minLength!){
            errorMsg = validation.errorMessage!.minLength!;
          }
          else{
            errorMsg = null;
          }
    } catch (e) {
      print(e);
    }
    return errorMsg;
  }


  InputDecoration getTextDecoration ({TextFieldModel? textFieldModel}){
      Widget? suffixIcon;
      if(textFieldModel!=null){
        if(textFieldModel.elementConfig!.resetIcon!){
          suffixIcon = const SuffixIconTextFiled();
        }
      }
      return InputDecoration(
          border: configurationSetting._textFieldConfiguration.border,
          enabledBorder: configurationSetting._textFieldConfiguration.border,
          hintText: textFieldModel?.elementConfig!.placeholder??"",hintStyle: configurationSetting._textFieldConfiguration.hintStyle,
          label: textFieldModel?.elementConfig!.label !=null && textFieldModel!.elementConfig!.label!.isNotEmpty?Text(textFieldModel.elementConfig!.label!,style: configurationSetting._textFieldConfiguration.textStyle,):null,suffixIcon: suffixIcon,counterText: ""
      );

  }

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
        TextFormField(
          focusNode: f1,
          readOnly: textFieldModel!.validation!.isReadOnly!,
          enabled: !textFieldModel!.validation!.isDisabled!,
          controller: _nameController,
          textInputAction: TextInputAction.done,
          maxLength: textFieldModel!.validation!.maxLength,   //It is the length of char
          maxLines: 1//textFieldModel!.validation!.maxLength,   // it related to input field line
          ,minLines: 1//textFieldModel!.validation!.minLength,  // it related to input field line
          //onChanged: (v) => _MyFormState.friendsList![widget.index] = v,
          ,
          decoration: getInputDecoration(),
          keyboardType: keyBoardType(),
          inputFormatters: inputFormatter(),
          validator: (value){
            if(textFieldModel!.valid! && textFieldModel!.validation!.required!){
              return checkValidation(textFieldModel!.validation!,value!);
            }
            return null;
          },
          onChanged: (value){
            if(mounted){
              widget.onChangeValue.call(fieldKey,value);
            }
        },
          onSaved: (value){
           /* f1.unfocus();
            FocusScope.of(context).requestFocus(f2);*/
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        fieldHelpText(),

      ],
    );
  }
}

