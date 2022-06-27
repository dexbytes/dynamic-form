import 'package:dynamic_json_form/src/suffix_icon_text_filed.dart';
import 'package:dynamic_json_form/src/model/text_field_model.dart';
import 'package:flutter/material.dart';

TextFieldModel? _textFieldModel;

get getTextFieldModel => _textFieldModel;
set setTextFieldModel (TextFieldModel value){
  _textFieldModel = value;
}

/*InputDecoration? _textDecoration;
InputDecoration getTextDecoration ({TextFieldModel? textFieldModel}){

  if(_textDecoration!=null){
    return _textDecoration!;
  }
  else{
    Widget? suffixIcon;
    if(textFieldModel!=null){
      if(textFieldModel.elementConfig!.resetIcon!){
        suffixIcon = const SuffixIconTextFiled();
      }
    }
    return InputDecoration(
        border: const OutlineInputBorder(),
        hintText: textFieldModel?.elementConfig!.placeholder??"",
        label: textFieldModel?.elementConfig!.label !=null && textFieldModel!.elementConfig!.label!.isNotEmpty?Text(textFieldModel.elementConfig!.label!):null,suffixIcon: suffixIcon,counterText: ""
    );
  }

}
set setTextDecoration (InputDecoration value){
  _textDecoration = value;
}*/

