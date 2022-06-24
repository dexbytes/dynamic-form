import 'package:dynamic_json_form/src/common_style.dart';
import 'package:dynamic_json_form/src/model/text_field_model.dart';
export 'model/text_field_model.dart';

class ResponseParser{
  TextFieldModel? textFormFiledParsing({required Map<String,dynamic> jsonData,bool updateCommon = false}){
    try {
      TextFieldModel textFieldModel = TextFieldModel.fromJson(jsonData);
      if(updateCommon){
            setTextFieldModel = textFieldModel;
          }
      return textFieldModel;
    } catch (e) {
      print(e);
    }
    return null;
  }
}

ResponseParser responseParser = ResponseParser();